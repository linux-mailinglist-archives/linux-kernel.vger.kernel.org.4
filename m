Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FFD707BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjERIQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjERIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF26310D0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED6F647E0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB25C4339B;
        Thu, 18 May 2023 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684397798;
        bh=u4N5s5RzImHaTfp18DwzdbANHCGhKwG99M7Qtmr7Vp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjQ0XqRWMp7+/p6DmBQ+47YMSdEedt1UquGqUhkhiY1xqKUJn1Fw66JdqI3VmQw+s
         C/lXPuwPYzNBoQC17STDr7VUDf17rl71CmamWt6ezDHfcB2S4FOfYwEUWSS8sEBRI9
         gB82/xUkGZilsGa59PD2CzJr89yfvwOI/LZjMObPa5jfg0eHVOF0kYkriJCDsllZ2k
         N7WG7SI2AeHs+Ciwc0YAgs/Jvbsjm2n9yOwhSXyomlv9nEhtDHRj0E1fjTL0WDzPsX
         yKWxunNaAlVDOJRdTZBz0yJe3B7S+Qtb6y+000qp/7qNwwEo9AD1HxxG/J+7IxBu4s
         KsTAAJlSOMtcA==
Date:   Thu, 18 May 2023 10:16:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, oleg@redhat.com,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 2/8] vhost/vhost_task: Hook vhost layer into signal
 handler
Message-ID: <20230518-zuschauen-windhund-48949c34a524@brauner>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-3-michael.christie@oracle.com>
 <CAHk-=wga+96PqV4x8EwFAMfi--m9essdX+3uPE-AoOSAQR1ddA@mail.gmail.com>
 <3c2adf29-c201-9534-cc07-d35c4dead948@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c2adf29-c201-9534-cc07-d35c4dead948@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 08:01:45PM -0500, Mike Christie wrote:
> On 5/17/23 7:16 PM, Linus Torvalds wrote:
> > On Wed, May 17, 2023 at 5:09 PM Mike Christie
> > <michael.christie@oracle.com> wrote:
> >>
> >> +       __set_current_state(TASK_RUNNING);
> >> +       rc = get_signal(&ksig);
> >> +       set_current_state(TASK_INTERRUPTIBLE);
> >> +       return rc;
> > 
> > The games with current_state seem nonsensical.
> > 
> > What are they all about? get_signal() shouldn't care, and no other
> > caller does this thing. This just seems completely random.
> 
> Sorry. It's a leftover.
> 
> I was originally calling this from vhost_task_should_stop where before
> calling that function we do a:
> 
> set_current_state(TASK_INTERRUPTIBLE);
> 
> So, I was hitting get_signal->try_to_freeze->might_sleep->__might_sleep
> and was getting the "do not call blocking ops when !TASK_RUNNING"
> warnings.

Also seems you might want to check the return value of you new helper...
