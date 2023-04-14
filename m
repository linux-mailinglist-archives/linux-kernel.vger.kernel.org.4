Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CD6E1EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDNJBf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Apr 2023 05:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjDNJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:01:33 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948315FDB;
        Fri, 14 Apr 2023 02:01:25 -0700 (PDT)
X-UUID: c572bfe768a64a25b70577dfefe129d1-20230414
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:d469cbe5-e8c6-45f3-b0d8-a5c91cf6496a,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:2
X-CID-INFO: VERSION:1.1.22,REQID:d469cbe5-e8c6-45f3-b0d8-a5c91cf6496a,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:2
X-CID-META: VersionHash:120426c,CLOUDID:d8a154a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230414092235ADH6FG27,BulkQuantity:2,Recheck:0,SF:45|38|24|17|19|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: c572bfe768a64a25b70577dfefe129d1-20230414
X-User: zhouzongmin@kylinos.cn
Received: from [172.20.12.156] [(116.128.244.169)] by mailgw
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1924047072; Fri, 14 Apr 2023 17:01:21 +0800
Message-ID: <a576df84ad459d13b18377bb64309fa80f1ea7f2.camel@kylinos.cn>
Subject: Re: [PATCH] Input: vmmouse - add macros to enable vmmouse relative
 mode
From:   zongmin zhou <zhouzongmin@kylinos.cn>
To:     Zack Rusin <zackr@vmware.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Apr 2023 16:58:21 +0800
In-Reply-To: <36d0b466c96b42f5fd364c2a80379d6d7be9cb48.camel@vmware.com>
References: <20230413085635.2515647-1-zhouzongmin@kylinos.cn>
         <36d0b466c96b42f5fd364c2a80379d6d7be9cb48.camel@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-04-14 at 01:22 +0000, Zack Rusin wrote:
> On Thu, 2023-04-13 at 16:56 +0800, Zongmin Zhou wrote:
> > Add macros to enable request relative mode.
> > 
> > Change the REL_Y value passed by input_report_rel function,
> > to match the direction of mouse movement.
> 
> Thanks for the patch, but in its current form it's a nack. First of
> all we don't
> want any defines in the driver code that affect compilation, it's
> never going to be
> tested or compiled in. Either a kconfig or a module parameter would
> be acceptable
> but that's only if you can actually explain what it is that you're
> fixing. The
> current single line description just mentions what the effect it has
> (not completely
> correctly either because for merged packets absolute will still be
> x=x, y=y, but
> relative will be x += dx, y -= dy) but not why it's done, what it's
> fixing and how
> to reproduce.
> 
> z
> 
Dear zack:

Firstly,thanks for your reply.

The reason I want to add macros to request different vmmouse
modes(relative or absolute) is that the vmmouse drivers currently only
supports request absolute mode.But in some case we want request
relative mode so that Pointer acceleration feature can be used.(as I
know,libinput module only support Pointer acceleration feature in
relative mode.)
So I think we can provide two vmmouse modes to facilitate the use of
different needs.
If need,I can change it to a kconfig or a module parameter.

The reasons of fix for REL_Y value，are as follows:
When I request relative vmmouse mode,and let mouse move up,the mouse
pointer moved down instead.
Similarly, when I move the mouse down, the mouse pointer moved up.
it obviously with a wrong motion direction in y.

Actually，I understand that the value of y here is the end calculation
result of relative coordinate movement，the real calculation is in
motion_event() of spice-gtk and  legacy_mouse_event() of qemu.

Test scenario:
1) start virtual machine with qemu command "vmport=on"，also with spice
protocal.
2) modify guest vmmouse drivers to request relative mode.
3) move the mouse,will observe the pointer freezed,it's because driver
not match the condition 'status & VMMOUSE_RELATIVE_PACKET',can't find
correct input device.need merge this patch in qemu:
https://lore.kernel.org/all/20230413081526.2229916-1-zhouzongmin@kylinos.cn/
4) after merge the patch in qemu,we can observe the issue of wrong
motion direction in y.

Looking forward to your reply.

