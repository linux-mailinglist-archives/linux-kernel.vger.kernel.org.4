Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41F659BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiL3UCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiL3UCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:02:49 -0500
Received: from ryne.moe (ryne.moe [157.90.134.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0774E1261F;
        Fri, 30 Dec 2022 12:02:45 -0800 (PST)
Received: from adrastea.localnet (unknown [170.55.83.2])
        by ryne.moe (Postfix) with ESMTPSA id 17F211900338;
        Fri, 30 Dec 2022 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redstrate.com;
        s=default; t=1672430564;
        bh=aveChmaN8G/lMNf9XyNe+rnT8SmfSevZ+682G76lGMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Royo1aU9SSa+p3/9rlt7WqnN1oCpG/U8J+FsoGcN5Nwz2qgsYuKnZyhE/187uR3p0
         JNChiHC0p7OCwF4yjQBJiS47Qfk4gJ7RqOz42pDKEgSBVTmpJ0b6YvyUZRhzZfPmhL
         NjTpV/Ocu4sR6O0cTdn2DVhDvi1yeAgFRsJgTPsw=
From:   redstrate <josh@redstrate.com>
To:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        kurikaesu@users.noreply.github.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Date:   Fri, 30 Dec 2022 15:02:41 -0500
Message-ID: <3448509.5fSG56mABF@adrastea>
In-Reply-To: <20221229190648.69040-1-jose.exposito89@gmail.com>
References: <2068502.VLH7GnMWUR@adrastea>
 <20221229190648.69040-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Joshua,
> 
> Thanks a lot for your patch!
> 
> It might cause conflicts with [1] and [2], so we'll need to rebase on
> top of each other work at some point.
> 
> [1]
> https://lore.kernel.org/linux-input/20221226123456.14822-1-jose.exposito89@
> gmail.com/T/ [2]
> https://lore.kernel.org/linux-input/20221226125454.16106-1-jose.exposito89@
> gmail.com/T/

I've seen those patches in the mailing list (and I thought they already got 
merged heh) so I'll keep a close eye and rebase as needed.

> 
> Sparse nitpick: "uclogic_extra_input_mapping" can be made static.
> 

I somehow missed that, will change.

> 
> Is it possible to receive a report with information from both dials at
> the same time?
> 
> I'm asking because I'm trying to understand what is the meaning of the
> 0x10 and 0x20 values and I wonder if they are generated when both dials
> are used at the same time.
> 

According to Aren's reference sheet he wrote up for this tablet, the 0x10 and 
0x20 values are reported by the right dial (left frame: 
02:f0:00:00:00:00:00:20:00:14, right frame: 02:f0:00:00:00:00:00:10:00:14). 
Dumping the contents of data[frame->bitmap_dial_byte] yields the same result. 
The left dial works like usual, 02 for left and 01 for right.

As for recieving reports of the two dials turning at the same time... I can't 
seem to make it do that. This tablet is pretty big, and I can't turn the dials 
fast enough.

> 
> You can probably reuse uclogic_params_ugee_v2_init() or at least reuse
> uclogic_probe_interface() and uclogic_params_parse_ugee_v2_desc() if
> for some reason we need custom logic for this tablet.
> 

I actually looked a little into the UGEE v2 init functions to see if I could 
reuse anything (but to be honest, I really just skimmed) but I will take a 
second look to see if I can consolidate it.

> 
> Is this value 8? In all the models I have seen so far this is indeed
> the number of buttons.
> 
> Also, what's the value of buf[6]? As you can see in
> uclogic_params_parse_ugee_v2_desc(), this field is the frame type. I'd be
> nice to know whether a different frame type is reported when 2 dials are
> present or not.
> 
> Could you attach the contents of the 14 bytes of "buf", please? I'd be
> nice to have a look and see if we can reuse as much code as possible.
> 

Yeah here's the 14 bytes of "buf" here:
buf[0] = 000c
buf[1] = 0003
buf[2] = 0030
buf[3] = 00ba
buf[4] = 009a
buf[5] = 0068
buf[6] = 0006
buf[7] = 0000
buf[8] = 00ff
buf[9] = 001f
buf[10] = 00ec
buf[11] = 0009
buf[12] = 0080
buf[13] = 0072

I'm not sure you made a typo, but buf[6] in uclogic_params_parse_ugee_v2_desc 
is reading the button count, which reports as 6 for some reason. buf[7] is 0 
though, so it appears that its still reporting as UCLOGIC_PARAMS_FRAME_BUTTONS 
(I could just be misunderstanding the strdescs) or the frames are completely 
different.

>
> Ideally, we should be able to handle this tablet with the other UGEE v2
> tablets.
> 

Yeah I will consolidate this case if I manage to merge this with the other 
UGEE v2 tablet support.

> 
> This array is already declared in uclogic_params_ugee_v2_init(), which,
> hopefully, we will be able to reuse. Otherwise, you might be interested
> in this commit (not merged yet):
> https://lore.kernel.org/linux-input/20221226125454.16106-4-jose.exposito89@g
> mail.com/T/#u

I didn't see that array in ugee_v2_init, what I'll do is match the variables 
defined in your cleanup patch (I believe it's closely identical already), so it 
makes rebasing easier no matter what order they're merged in.

> 
> Can't "uclogic_rdesc_ugee_v2_pen_template_arr" be used instead?
> 

Yeah I think so, at first I didn't consider it but on closer inspection - the 
offsets are the same (just for some reason, out of order). I'll be looking into 
testing the pen using this descriptor on the second revision, maybe Pro-series 
and UGEE v2 aren't so different after all!

> 
> Have a look to "uclogic_rdesc_ugee_v2_frame_dial_template_arr", I don't
> know if it could be used for your tablet.
> 

Same as above, same structure - different order (but it's all semantic, same 
offsets) so I'll be consolidating if it works out.

>
> If your tablet reports its number of buttons, UCLOGIC_RDESC_FRAME_PH_BTN
> can be used here.
> 

I'll be reviewing the descriptor data, ideally it should but I don't have high 
hopes (as shown above) but I'm going to be testing it more.

Thank you for the review! I'll be resubmitting a second version of the patch 
with your suggestions and making sure the kernel test bot is happy - and 
hopefully there will be a lot less duplication structure-wise.




