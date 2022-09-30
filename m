Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1F5F12D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiI3Tjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiI3Tjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:39:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD1510CA;
        Fri, 30 Sep 2022 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UuJ7YHD62NCWF87PoNQIRR0XqMDKifEIJpbvX6nWbGI=; b=b7wpEEBn/MeUzb65Jo1nFFoOd6
        jF4HQcj1wjX70b82ALDjAbucDEWO+Cbdp8AEbjBxghOqYTvKPMqKJDtvLIIZrslw8yUW3eZ1SnBot
        +BhTIxFVQe9z2gF63BVmhZdj0gB5TcL+nxe34vRGG1f4WMvr/UNCiQ27dXkEfd7fVmQB+sioZZtZU
        zLJk2XbtP4G7BwBPPweydaE0RP+E7L82R1YcMkE6xmor9kzdyBBqRR5Yq5WZvKth3wNAKz3dJ3Ij3
        VrjdzoQ/19zray8jQP9lA9mNo1UaGLMI3s7otk4jatYjD9FMpYdRPvpxpvGbhQmnB6RN+injfwPSp
        dfMe0ZZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oeLr5-00BEOb-M4; Fri, 30 Sep 2022 19:39:27 +0000
Date:   Fri, 30 Sep 2022 12:39:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 6/7] module: Improve support for asynchronous module
 exit code
Message-ID: <YzdF72yRae7lnZAy@bombadil.infradead.org>
References: <20220914225621.415631-1-bvanassche@acm.org>
 <20220914225621.415631-7-bvanassche@acm.org>
 <a4084b27-dd2d-10df-493c-35998eed664c@acm.org>
 <YzOPJHSQsPtc5o0Y@bombadil.infradead.org>
 <33ee1c3a-d37a-b81f-68be-d1901c7dd6e8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ee1c3a-d37a-b81f-68be-d1901c7dd6e8@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:17:02AM -0700, Bart Van Assche wrote:
> On 9/27/22 17:02, Luis Chamberlain wrote:
> > On Tue, Sep 20, 2022 at 10:13:40AM -0700, Bart Van Assche wrote:
> > > On 9/14/22 15:56, Bart Van Assche wrote:
> > > > Some kernel modules call device_del() from their module exit code and
> > > > schedule asynchronous work from inside the .release callback without waiting
> > > > until that callback has finished. As an example, many SCSI LLD drivers call
> > > > scsi_remove_host() from their module exit code. scsi_remove_host() may
> > > > invoke scsi_device_dev_release_usercontext() asynchronously.
> > > > scsi_device_dev_release_usercontext() uses the host template pointer and
> > > > that pointer usually exists in static storage in the SCSI LLD. Support
> > > > using the module reference count to keep the module around until
> > > > asynchronous module exiting has completed by waiting in the delete_module()
> > > > system call until the module reference count drops to zero.
> > > 
> > > Hi Luis,
> > > 
> > > I'd like to know your opinion about this patch since you are the maintainer
> > > of the kernel module system.
> > 
> > See this patch which extends the documentation of try_module_get():
> > 
> > https://lkml.kernel.org/r/20211029184500.2821444-7-mcgrof@kernel.org
> > 
> > You can ignore discussion around the thread as sadly it is just
> > irrelevant stuff not about that patch. But the logic it spells out
> > is still true.
> > 
> > So, in short, using try_module_get() on exit is actually the wrong
> > thing to do and it is no surprise it would fail. I haven't gotten
> > yet around to reviewing Mauro's driver API which let's you unbind
> > drivers, but it sounds related so I CC'd you on that.
> > 
> > So I'd like to ask instead if an alternative to using try_module_get()
> > on exit would be better here and for the future.
> 
> Hi Luis,
> 
> The extended documentation of try_module_get() is very helpful. But please
> note that this patch is not related to try_module_get() at all. See also
> patch 7/7 in this series (https://lore.kernel.org/linux-scsi/20220914225621.415631-8-bvanassche@acm.org/).

I cannot see how this patch set is no way related to try_module_get()
given the 7/7 patch you posted replaces try_module_get() with __module_get().
My point, and hint, is that the original construct that added try_module_get()
on removal was flawed and I'm not sure trying to expand on that idea would
or even *should* be fruitful given the issues / tribal knowledge I tried
extending documentation for.

It would beg the question if instead re-evaluating the goal could be
done in such a way that the new documentation I suggested on try_module_get()
would be seriously taken into account.

  Luis
