Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5965B436
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbjABP3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:29:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED58FFFF;
        Mon,  2 Jan 2023 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672673338; bh=DkGt1eCxxN8PX6FO9pxQ90B7u0RDcF4MmuhsN+3Bmxs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=b3VDJcR3fy4VS2ddCMT/Hr24KqojpgSyzHGvFHNoJU7MHKzKBV8e0MziE4m/LUmUU
         aGX37QoOdU3f4eh+U7kgWwmq07F2t8C1irt3Sa3BrMBZ8UDl/AHXQ/iffpVfuMqrYW
         2Ps89f54TbISfOLjFWgPRUGp+T4f44ykzPbwYTmV7t3u+xegTJDQGnQlhd0Gl3MJtM
         2eDlfye3mzCwTtFLvytrjbv4Ud0o8AuuoSu0JJreYA8fHDQC6ISWHRQXeq/sTNBK3l
         IaVaRmRTAVtqF8Vo2zKoIejb0dX3ADQvPyGBASEWwBymkEOgcsUyLtgRzmm4dsO4sy
         BA59yTEZeX2AA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.130.137]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1p5S2z3351-00Buoi; Mon, 02
 Jan 2023 16:28:58 +0100
Message-ID: <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
Date:   Mon, 2 Jan 2023 16:28:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fbmem: prevent potential use-after-free issues with
 console_lock()
Content-Language: en-US
To:     Hang Zhang <zh.nvgt@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221230063528.41037-1-zh.nvgt@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221230063528.41037-1-zh.nvgt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aTcReHIKu+xxJWbzwqX228SBD5Luh+xZ4uzZ4/xjCzTqWPcYQAO
 vPsYbvU1YupcRWWP+eq/Yx6OmWVqEsaERdkaTjdfJLXr8quiBJHLIk041Ygr12OTSCQyFL7
 cF+zCZhBIS5mCq0omgQiDgoW0wycSgjp+rGzaKhWyPG2RH95JKmklZlkn71voObiENfRfIk
 zkAckz8iC7ibykuq2+TJw==
UI-OutboundReport: notjunk:1;M01:P0:pBymp9236EI=;da+v+g8Y0TYN9jtrRxxfqcmbjQd
 LxeAPwsghelbrg5gSmXj2YO8H76ZdpR5nLQGGr3xq941tHQKF1fT4bMV96VLRyrI7bNY5K/0L
 9WqjvbyEUVAiAe1lN6A8XjTL5fIB5HParLv80hG9LwU7uIoYL0lOfIk6J89BAru5ctaTMvvGu
 tWIU2QzAXyM6VYI6UUCcOdDr/5MdUvN0p9dRuetMZbjpzR5Scm7CTSsK5GmUwFoVEjkX6g49B
 h5ZvWyNNKxwUljFaQV14jch3Wyyu5hK8jgVSqGKHTyBLrbBxffdItnWxA1tnz7nNVUBm8L2C6
 4IMfHZM2Mk9VQUsLDRXVagkinA3/TG2P0ya0PE6lCtfk0PxC7YncMsdcaLDhWrvUuAMzbCKNn
 xHyF+Bz9RmOGmiXk2qM3vRn6p5TlB75ZZoJCYVovf2od3Onllpo6CtIlsCTvHsjnF1xuYqGM4
 xi7f9/aL8obs1GGBP5NfUFyZkwG64xds2YYYEvPVKTxjiHf71C3pDfj/yn6XmRn3A/Twqld3e
 RsPgsnIt5zTiUakqa1FzR3u04rbXcKHlwUHTd7eLLXpBXPfopl5vvtpFFd3p60ITtmax6B770
 8G6zFAoO0psQgy1TorcqltKw94FWQWRSuRF6j/CpWBf/7GZlQjV94Aqq6W4qveeqd8Mal0HHg
 3uYSm5LuuNgLnwBNER4d0WMaVgnxS4UEIf7w+SNaJBTI7d/fhcHc6/fRyGMnzMk01BdqsIgae
 CjhrVEWry2Fl1HCXHFIXu5qRHng4x+EH+sJk0R0g4TOLOwsLlOlEoPxOSkOcokFU89o2WTH9A
 vz2G3IZFgc+8Ad8J2knimcLipOOoyaXhnaYu3h9uiNa6MEAn3KBxgP+au/BKVMDVGSX8T+mWP
 averrVrAVE1WdMCLepTqwqskAVvCZGm01Y+w7SNsJ+Uba3Vkgp5FUlSoJRdUWw9btHR/5T03w
 rwuIrTXQYS9XoSCuj5yfTDCsfqA=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/22 07:35, Hang Zhang wrote:
> In do_fb_ioctl(), user specified "fb_info" can be freed in the callee
> fbcon_get_con2fb_map_ioctl() -> set_con2fb_map() ->
> con2fb_release_oldinfo(), this free operation is protected by
> console_lock() in fbcon_set_con2fb_map_ioctl(), it also results in
> the change of certain states such as "minfo->dead" in matroxfb_remove(),
> so that it can be checked to avoid use-after-free before the use sites
> (e.g., the check at the beginning of matroxfb_ioctl()). However,
> the problem is that the use site is not protected by the same locks
> as for the free operation, e.g., "default" case in do_fb_ioctl()
> can lead to "matroxfb_ioctl()" but it's not protected by console_lock(),
> which can invalidate the aforementioned state set and check in a
> concurrent setting.
>
> Prevent the potential use-after-free issues by protecting the "default"
> case in do_fb_ioctl() with console_lock(), similarly as for many other
> cases like "case FBIOBLANK" and "case FBIOPAN_DISPLAY".
>
> Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>

applied to fbdev git tree.

Thanks,
Helge

> ---
>   drivers/video/fbdev/core/fbmem.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core=
/fbmem.c
> index 1e70d8c67653..8b1a1527d18a 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1182,6 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsi=
gned int cmd,
>   		console_unlock();
>   		break;
>   	default:
> +		console_lock();
>   		lock_fb_info(info);
>   		fb =3D info->fbops;
>   		if (fb->fb_ioctl)
> @@ -1189,6 +1190,7 @@ static long do_fb_ioctl(struct fb_info *info, unsi=
gned int cmd,
>   		else
>   			ret =3D -ENOTTY;
>   		unlock_fb_info(info);
> +		console_unlock();
>   	}
>   	return ret;
>   }

