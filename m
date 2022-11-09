Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11993622B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiKIMJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKIMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:09:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8918B10FC0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:09:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24DE861A51
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66AEC433D6;
        Wed,  9 Nov 2022 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667995751;
        bh=I1TqxwsgYjSqK2MI2Hxtj+/lmCs/5QlrHAeZidaInuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJZoCFvf6eEQ37NOS5FkpCwseBOpl2S32vQC/ITSzhKm++1p9T7KxB2G+MeX+LtS5
         jo5Dlb7Cl4Lb/L6OaHWkBvEIeuohesLVve46qjaqu+mCd50r1x7Bven5n8OMHT/ZcU
         i/3KN6t3Rsd2//5HWQr3atfHxW/lqm50XhSdsgY0=
Date:   Wed, 9 Nov 2022 13:09:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, zhengyejian1@huawei.com,
        dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org, sivanich@hpe.com, lkp@intel.com
Subject: Re: [PATCH v8] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <Y2uYZFqzYdG/oJCY@kroah.com>
References: <20221109105158.230081-1-zyytlz.wz@163.com>
 <Y2uLK6Zxsz9TD9WV@kroah.com>
 <CAJedcCyN+D+gsVo10r-bGpAtnL4x_N3TpqhVYBi1P7=dD8fNCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJedcCyN+D+gsVo10r-bGpAtnL4x_N3TpqhVYBi1P7=dD8fNCw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:04:04PM +0800, Zheng Hacker wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2022年11月9日周三 19:12写道：
> > >       /*
> > >        * If the current task is the context owner, verify that the
> > > @@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_thread_state *gts)
> > >        */
> > >       gru = gts->ts_gru;
> > >       if (!gru || gts->ts_tgid_owner != current->tgid)
> > > -             return;
> > > +             return ret;
> >
> > Why does this check return "all is good!" ?
> >
> > Shouldn't that be an error?
> >
> This check is something like "if the gts has been initiiazed properly".
> If it's not, I thinks we shouldn't treat the gts like something very
> bad happend. Because in the later request, the gts can still have a
> chance to be configed/updated properly. This is different from "it's
> too bad so we have to unload gts right now". This is just my personal
> point of view. Besides, the caller of this function have token it into
> consider. In gru_fault, it will try again and in gru_handle_user_call_os,
> it will return -EAGAIN. In gru_set_context_option, it will be fine
> because there won't be any operation on gts->ts_gru or gts->ts_tgid_owner

Then you need to document it why this is "success" as it is not obvious
at all.

thanks,

greg k-h
