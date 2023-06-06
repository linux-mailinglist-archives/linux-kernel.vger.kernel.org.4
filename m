Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D990724A8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbjFFRuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbjFFRuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:50:08 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C5610FF;
        Tue,  6 Jun 2023 10:50:06 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 25CD34D1; Tue,  6 Jun 2023 12:50:05 -0500 (CDT)
Date:   Tue, 6 Jun 2023 12:50:05 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH] capability: erase checker warnings about struct
 __user_cap_data_struct
Message-ID: <20230606175005.GA639588@mail.hallyn.com>
References: <20230602054527.290696-1-gongruiqi@huaweicloud.com>
 <20230606032844.GA628899@mail.hallyn.com>
 <CAHC9VhT8k87SdD4_JQFwXShwJeBb3KU7C+R5ABAOhDGvvC0X+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT8k87SdD4_JQFwXShwJeBb3KU7C+R5ABAOhDGvvC0X+w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 12:45:00PM -0400, Paul Moore wrote:
> On Mon, Jun 5, 2023 at 11:29 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Fri, Jun 02, 2023 at 01:45:27PM +0800, GONG, Ruiqi wrote:
> > > Currently Sparse warns the following when compiling kernel/capability.c:
> > >
> > > kernel/capability.c:191:35: warning: incorrect type in argument 2 (different address spaces)
> > > kernel/capability.c:191:35:    expected void const *from
> > > kernel/capability.c:191:35:    got struct __user_cap_data_struct [noderef] __user *
> > > kernel/capability.c:168:14: warning: dereference of noderef expression
> > > ...... (multiple noderef warnings on different locations)
> > > kernel/capability.c:244:29: warning: incorrect type in argument 1 (different address spaces)
> > > kernel/capability.c:244:29:    expected void *to
> > > kernel/capability.c:244:29:    got struct __user_cap_data_struct [noderef] __user ( * )[2]
> > > kernel/capability.c:247:42: warning: dereference of noderef expression
> > > ...... (multiple noderef warnings on different locations)
> > >
> > > It seems that defining `struct __user_cap_data_struct` together with
> > > `cap_user_data_t` make Sparse believe that the struct is `noderef` as
> > > well. Separate their definitions to clarify their respective attributes.
> > >
> > > Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> >
> > Seems ok.
> >
> > There's still so much noise in the make C=2 output even just for
> > kernel/capability.c that I'm not sure it's worth it, but no
> > objection.
> >
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> 
> I'm guessing you would prefer if I pulled this via the LSM tree Serge?

Yes, please.

> FWIW, if that is ever the case for future patches, just add a note
> when you ACK something and I'll pick it up.

Thanks, will do.

If it starts happening more than once or twice a month, then I'll get my tree
into shape and start cueing up patches...
