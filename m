Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9044C6573C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiL1H6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiL1H6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:58:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B75BEA0;
        Tue, 27 Dec 2022 23:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672214290; bh=cXJ87oJBwBaxFCFIb6cYyvIrq6iLUXOa4/DOQ+Am96A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HAID7YT/vNUrVzsXDM4XmHQ6JmeC9tdByp0B27sHicNFTVdMkh8zu75WMZSQldfR5
         dB2TFhqzCf79QB3dd0mLJAMej+QTcKhd74lxDQtpPmHcVue58cB7O2lxmyWKOVgdA2
         OAEl1i2h08BMpGGovfROJYmnBC6E3JmBOERp2u5512tv+ife6GkjYAbJ370KgYbF1f
         /SFrBW4OCe35V6D3AW+ib4LdC3sEpSLvA+b7Q3ZHNNZJf7CKVv1+8YWj9d04T9dkWJ
         2p5ZZQ7At665pHPl0UMQ3ho9i8MC1/EfkJzVbBENdcSROaBp9+jC3s5nIZKi2TPY4y
         RSaaDDBb75YXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.184.137]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1oi9c41F78-013b6v; Wed, 28
 Dec 2022 08:58:10 +0100
Message-ID: <ffcf3922-1ff9-ed2b-619b-d411a8eb70fc@gmx.de>
Date:   Wed, 28 Dec 2022 08:58:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH linux-next] fbdev: use strscpy() to instead of strncpy()
Content-Language: en-US
To:     yang.yang29@zte.com.cn
Cc:     javierm@redhat.com, tzimmermann@suse.de,
        christophe.leroy@csgroup.eu, wsa+renesas@sang-engineering.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
References: <202212280944112670081@zte.com.cn>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202212280944112670081@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AAhu+1ssDZWoHC1JNYuG/2KCh1p3zsD72YAqTRmf05EsUPmyzrO
 QHsOOUBkSPhImYBWLCA4t1tg3wqvfaSlkTA/8WblTxjmF1CvOGiNqHRiEm8ChyQY/S9m7lv
 6njdih102P3MBEJaajcYb4iArArBV2eZ7XDl9cxSu02R8aoC0Pwxxn1xFB72dnrGrVzAIIt
 gzTblnWClmCUunfgBq7lA==
UI-OutboundReport: notjunk:1;M01:P0:/lN6jKlBR/I=;M3jUZ8kAf5uIo42ps8BktURfzoO
 FfV8zcPRYC4H3d82KSGL4FD5CA5b0ew5WWbJvwf8TrV9R+M0FS8mpXsNSmw3k9fTupky5SpN7
 sML67Fpa90FZgmXkBxKcZHt9wVTiSC54fhAY0zaehxcde9uiY/B7nUfxawn9cQTv+f4nE9DFO
 Bkf36cILJt8xAm1fREb2nzBtd4LAWiruBFs/SMwIwzTP6PdE0b7702vEG1vXbBK5TcTuKDfFB
 6b98tGnR/RHSgvxeQPkSFJjVJhdSciJwVvZ4muJr9ux3vTzbRAQkhCyKUgR1r2+ovo5fWc8Xr
 +tQJaxOCuCz3dH/hLAhDtQchRl2G2C9XTUr3+RDBtP+e5zG5sq9TfP1M913Yp2IBIrX2beKF8
 A1JoqEgwfUTaB0wdPnZAJ9AqNnYO2t7lxifQ1u6AwCUy2eZ70Wex3Z2RaA4coH/XMRTKH458B
 2woMGtbMESSS3Uf9f3KxjiWBL7RP9RVjrIEmNCyzPC8pSk3ejkN33iW1zE8BMzC0MuBDnVi4H
 3tnPo8D/YZgcmympvP2ou225SEvVkLn/XyCcO/a/5xanNdQSSu/DR5V5seHWfzy0pcKhNTTy0
 9VzeUrRqFlE6y1LF/8KwTW94hU1QQkIKHdtdVU2Uh2WoLF7YB9NcbicfNGp7mgpCT8Q0GxQfv
 oe6XMITK2f2qLP4KqjmubSUkGbtUwrFpyOofFRwdLPAvFIOW7zyejZKa5u12BwMJo1IQqAu2D
 EscPnX5RDGolSTmal4UELaHjECDs4swcYcRMc1GkOukg6pIHnEYUGzdUJoYO+T4y5ZecWQJdr
 zovaUo1r8Ta8SAm67BT83Q1VFKePKYB9cgv8g6wIJpLyV0ppFz4UEmSTdaWuyAqdX9hBqIL9V
 6GVaThopKQkwi38AaEFCimKc3v20Ln0/ahu3XkZ4365ma4c3uoc4f2LEyPjpnxQ2WPmpVryLg
 NxLfhHirTVxZnqbzwD3Pf4j8RWI=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 02:44, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>   drivers/video/fbdev/aty/atyfb_base.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

applied.
Thanks!
Helge


>
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/=
aty/atyfb_base.c
> index 0ccf5d401ecb..851c1236fddb 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -3192,8 +3192,7 @@ static void aty_init_lcd(struct atyfb_par *par, u3=
2 bios_base)
>   		 * which we print to the screen.
>   		 */
>   		id =3D *(u8 *)par->lcd_table;
> -		strncpy(model, (char *)par->lcd_table+1, 24);
> -		model[23] =3D 0;
> +		strscpy(model, (char *)par->lcd_table+1, 24);
>
>   		width =3D par->lcd_width =3D *(u16 *)(par->lcd_table+25);
>   		height =3D par->lcd_height =3D *(u16 *)(par->lcd_table+27);

