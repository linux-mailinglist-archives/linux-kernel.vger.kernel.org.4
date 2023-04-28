Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57906F1063
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 04:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbjD1Ceo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 22:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344285AbjD1Cel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:34:41 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437BA268D;
        Thu, 27 Apr 2023 19:34:39 -0700 (PDT)
X-UUID: bab8557de2614e4db63975e2d6b413c9-20230428
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:355ed47d-ac2f-4707-a690-978faf3e105e,IP:5,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:15
X-CID-INFO: VERSION:1.1.22,REQID:355ed47d-ac2f-4707-a690-978faf3e105e,IP:5,URL
        :25,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:15
X-CID-META: VersionHash:120426c,CLOUDID:b8cf286a-2f20-4998-991c-3b78627e4938,B
        ulkID:2304271036120J5N91TN,BulkQuantity:2,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: bab8557de2614e4db63975e2d6b413c9-20230428
X-User: zhouzongmin@kylinos.cn
Received: from [172.20.12.156] [(116.128.244.169)] by mailgw
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1309738458; Fri, 28 Apr 2023 10:34:24 +0800
Message-ID: <9d739de8fec7683c3a71bc1be3229818325ade0b.camel@kylinos.cn>
Subject: Re: Re: [PATCH] Input: vmmouse - add macros to enable vmmouse
 relative mode
From:   zongmin zhou <zhouzongmin@kylinos.cn>
To:     Zack Rusin <zackr@vmware.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Apr 2023 10:34:23 +0800
In-Reply-To: <rk3ip31xbz-rk4smwgz5s@nsmail7.0.0--kylin--1>
References: 59df37cf089230dc6d2d62f2ee539ee90f72388b.camel@vmware.com <rk3ip31xbz-rk4smwgz5s@nsmail7.0.0--kylin--1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-20 at 09:49 +0800, 周宗敏 wrote:
> > Dear zack:
> >  
> > As far as I know, I think in the current design for vmmouse device,
> > the mouse mode can only choose one,can't request both two mode.
> >  
> > The flowchart for vmmouse device between host and guest roughly as
> > > follows：
picture link: https://imgs.wiki/imgs/2023/04/28/1898b0428ecb366a.png

> > QEMU VMMouse emulation code defined variables of 's->absolute'
> > to identify the mouse mode requested by the guest driver.
> > Based on the value of 's->absolute',qemu will add different >
> > spice-input VD-Interface,
> > spice-server will notify client to use the correct mouse mode, 
> > and then spice client will update mouse motion/position based on
> > the > mouse mode.
> >  
> > About the VMMOUSE_RELATIVE_PACKET events,I guess that designer may
> > > want use it
> > to distinguish relative from absolute of the process events.But >
> > doesn't mark them as such
> > on QEMU's vmmouse device code.In fact, the status corresponds to
> > the > following buttons value on QEMU：
link: https://imgs.wiki/imgs/2023/04/28/2c6a92c33e2537dd.png
> > 
> > From the screenshot we can know it didn't mark the mouse mode
> > status > on original design,
> > only set the actual button state. So I think have to mark it here >
> > according to the value of 's->absolute'.
> >  
Dear zack:

I guess the last mail sent to you may has been lost 
as I don't see it in lore.kernel.org.Just resending it.

If you have any questions, please let me know.
Thanks.
> > Best Regards.
> > 
> > ----
> >  
> > 
> > 
> > 
> > 主　题：Re: [PATCH] Input: vmmouse - add macros to enable vmmouse >
> > relative mode 
> > 日　期：2023-04-14 23:32 
> > 发件人：zackr@vmware.com
> > 收件人：dmitry.torokhov@gmail.com;Pv-
> > drivers;zhouzongmin@kylinos.cn;Linux> -graphics-maintainer;
> > 
> > On Fri, 2023-04-14 at 16:58 +0800, zongmin zhou wrote:
> > > > On Fri, 2023-04-14 at 01:22 +0000, Zack Rusin wrote:
> > > > > > On Thu, 2023-04-13 at 16:56 +0800, Zongmin Zhou wrote:
> > > > > > > > Add macros to enable request relative mode.
> > > > > > > > 
> > > > > > > > Change the REL_Y value passed by input_report_rel
> > > > > > > > function,
> > > > > > > > to match the direction of mouse movement.
> > > > > > 
> > > > > > Thanks for the patch, but in its current form it's a nack.
> > > > > > First > > > of
> > > > > > all we don't
> > > > > > want any defines in the driver code that affect
> > > > > > compilation, it's
> > > > > > never going to be
> > > > > > tested or compiled in. Either a kconfig or a module
> > > > > > parameter > > > would
> > > > > > be acceptable
> > > > > > but that's only if you can actually explain what it is that
> > > > > > > > > you're
> > > > > > fixing. The
> > > > > > current single line description just mentions what the
> > > > > > effect it > > > has
> > > > > > (not completely
> > > > > > correctly either because for merged packets absolute will
> > > > > > still > > > be
> > > > > > x=x, y=y, but
> > > > > > relative will be x += dx, y -= dy) but not why it's done,
> > > > > > what > > > it's
> > > > > > fixing and how
> > > > > > to reproduce.
> > > > > > 
> > > > > > z
> > > > > > 
> > > > Dear zack:
> > > > 
> > > > Firstly,thanks for your reply.
> > > > 
> > > > The reason I want to add macros to request different vmmouse
> > > > modes(relative or absolute) is that the vmmouse drivers
> > > > currently > > only
> > > > supports request absolute mode.But in some case we want request
> > > > relative mode so that Pointer acceleration feature can be
> > > > used.(as > > I
> > > > know,libinput module only support Pointer acceleration feature
> > > > in
> > > > relative mode.)
> > > > So I think we can provide two vmmouse modes to facilitate the
> > > > use > > of
> > > > different needs.
> > > > If need,I can change it to a kconfig or a module parameter.
> > > > 
> > > > The reasons of fix for REL_Y value，are as follows:
> > > > When I request relative vmmouse mode,and let mouse move up,the
> > > > > > mouse
> > > > pointer moved down instead.
> > > > Similarly, when I move the mouse down, the mouse pointer moved
> > > > up.
> > > > it obviously with a wrong motion direction in y.
> > > > 
> > > > Actually，I understand that the value of y here is the end > >
> > > > calculation
> > > > result of relative coordinate movement，the real calculation is
> > > > in
> > > > motion_event() of spice-gtk and legacy_mouse_event() of qemu.
> > > > 
> > > > Test scenario:
> > > > 1) start virtual machine with qemu command "vmport=on"，also
> > > > with > > spice
> > > > protocal.
> > > > 2) modify guest vmmouse drivers to request relative mode.
> > > > 3) move the mouse,will observe the pointer freezed,it's because
> > > > > > driver
> > > > not match the condition 'status &
> > > > VMMOUSE_RELATIVE_PACKET',can't > > find
> > > > correct input device.need merge this patch in qemu:
> > > > https://lore.kernel.org/all/20230413081526.2229916-1-zhouzongmin@kylinos.cn/
> > > > 4) after merge the patch in qemu,we can observe the issue of
> > > > wrong
> > > > motion direction in y.
> > 
> > Sounds like you have a bug in the monitor code to me. The mouse
> > might > request
> > relative mode, but that doesn't mean that it's going to be
> > switched, > it's a hint. On
> > enable we definitely want to request the default absolute mode.
> > 
> > Ultimately it's the delivery mechanism (i.e. whether the delivered
> > > event is
> > VMMOUSE_RELATIVE_PACKET or not) that defines what an event is. This
> > > sounds to me
> > like the monitor delivers VMMOUSE_RELATIVE_PACKET events but
> > doesn't > mark them as
> > such. You can confirm by putting some debugging output in the >
> > vmmouse_report_events.
> > 
> > z
> > 

