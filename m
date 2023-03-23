Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA66C6590
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjCWKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCWKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B631F5F7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 891E6625B4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE3AC433D2;
        Thu, 23 Mar 2023 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679568291;
        bh=3vX3C03J8BhEoEqAwZ/7TgV5jTjsf+HuXjGcKHODEGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ix0fu/BI4RDZ8boPc/8IHjq9Q0Lo7fhzfQzUCQp2itYBwv33gsrWOm20m0QyIEj36
         Kj6XLYqil3ykTTKoNypeOOr1pSu2s0fqrkuTKdfkQtvxhhh5kcg53vtoDGnzZyqm5p
         hTabvcpYg8JSOov39Q1sAk4n/m9BLW+JiQDbK5xAfWMsaVrSWe6y+8zpyCBTfliFHt
         pl+CvYcxP2GukwFYxFwl2h/M6J4bJKetQt8IVgOCl2eA8PA4Q7tO1Vz73jmk+Dfmw+
         jGp2t7INtFOPUUmscWZPeE4SOjSsLQU1YrClYE882M8ICHvHysOh0VFdrwzaLpGaFt
         WWRVB3U+dNYfw==
Date:   Thu, 23 Mar 2023 11:44:45 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323104445.qidusxeruimeawy6@wittgenstein>
References: <20230322185605.1307-1-michael.christie@oracle.com>
 <20230323033557-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230323033557-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 03:37:19AM -0400, Michael S. Tsirkin wrote:
> On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
> > vhost_task_create is supposed to return the vhost_task or NULL on
> > failure. This fixes it to return the correct value when the allocation
> > of the struct fails.
> > 
> > Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
> > Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
> > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> The affected patch is not upstream yet, right?
> I don't know if the tree in question allows rebases - linux-next
> does. So ideally it would be squashed to avoid issues during bisect.
> Still it's error path so I guess not a tragedy even without squashing.

I tend to not rebase once stuff has been in linux-next but I make
exceptions as long as it's before -rc4. For now I've put the patch on
top (see the other mail I sent) but if it's really important I can
squash it after the weekend (I'll be mostly afk until then.).
