Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7D56573C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiL1H7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiL1H7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:59:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F50CEA0;
        Tue, 27 Dec 2022 23:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672214307; bh=ut0QnBH+n52wyKHqQwBmihflDips2qqky7SOU6xr2yk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eN4Ex5QIPgdWjYcTYy02q5aoymbvKY1bYLviQ/rRbu0eSYMZYvDKomIFZwyNpSL6X
         dDOlDBXZU4g0zLRxV0OxLqMb9jix3i5YNyaXWlN0Ka+e3fgKL15J32gphECk6EMM7y
         cfjWG4Tz9e36ntSPS253HeVp+vP17JdNUBl2E5by+N7Y6jh/jAqRCy67LhtnlOLm6o
         G+LZqLeLqTG9nX2vnX+UGBjeNOETP1nvbjzFH3/v7kPl83v9rvCMZ7VbBybaPGfRE4
         2+nWnwa24JVg8yE75z9IdoUKneFPViOCAR6FBG9Z6bMeE9NMA+MIr0supORmd6XdQF
         Wvm1t9CQH48RQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.184.137]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1oSGsF2jrc-00iCsh; Wed, 28
 Dec 2022 08:58:27 +0100
Message-ID: <10b15ff6-0671-a523-a708-76f1dfa0383e@gmx.de>
Date:   Wed, 28 Dec 2022 08:58:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH linux-next] fbdev: omap: use strscpy() to instead of
 strncpy()
Content-Language: en-US
To:     yang.yang29@zte.com.cn
Cc:     tony@atomide.com, b.zolnierkie@samsung.com, arnd@arndb.de,
        yuzhe@nfschina.com, jiapeng.chong@linux.alibaba.com,
        guozhengkui@vivo.com, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
References: <202212280940017919910@zte.com.cn>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202212280940017919910@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6xYT7XBtpcRWzDX6SMR5Z8MDNCitrlJnvbo6qFAtHCUpmmFKG34
 DRPCkQvPUUNTq4SCURlK0nW2KbSdPE5Grhs+SCPnjG/D6UE8SdJcq6trxfGRFDV4ZuurelR
 zYw9zApIoPh+QWH9UbFNIYmcfnm6xI2/COONct/6CTwTjyCUFD+izjSkiIBF2L0gY2tMMdL
 OatStnnePHFTsFj5928yQ==
UI-OutboundReport: notjunk:1;M01:P0:dneBwogOC4o=;S5DKRe/GJouDkmz713c8D7GJqKU
 smMzawgYoxAlQfzoJG7OXVgQcpjkt0IqYNibKYZVNkL2RQRa7gXQ1lrTQsyKPGWl9CrX+7x/S
 HYNu+j2+k7b+uybzfaetqpRO7G9vBLo9113eU2gXJ8Jft0dGNt7+ig8rJAHnIGB11Q/aU9mc1
 jamMY/chikb/PyJis3Gj/tNPtorYqoHvDMV9xa8W4LKoR6aFAFkMYf8qWmI87dZNJ4gCGiJCS
 kTx2vXFySUiydsVkvPxrciN05hMZOqt05nw1LFJjxIcAuyFEQ7zvAkBFMfSc8W5rgyPiddNyT
 9c7td3QC0z/0hmVWWvZoAe9xbd25xFcpvYcI4tpeRc7JHj1RVwlpsSDmN1+qtsETI3RM1YYA0
 sVE4F5QcqsS2wuwb8J/gKg3m5a1AYnUMvryyvnLD1lFetZcJCSXY/AjHZb876N1aopDWNiVOQ
 5F/UsAU+tUSRuJAPhmN3PYJgiUGRFDKQkalmiGHrto4JoXyHDggqvBsJsffnqbm0NT8my9hUZ
 8wdEeN2AB7PJ8CZWJH/Pb/owXT6XnCTZCifnZL76LBYF/pHWyzqGwG/azsCGeV/9jpvUzKVO4
 02KtXNoDD+PfphySAkjnEDzt2czFaRFLB1yvxfSgz0jU+HmgSXwpAiFfCw5JluOESFCJNzjVr
 loYNzfH+SMkrk57A8cGmw49z+l3TbhJnw63OqbcbWEIQxYAOIgVpG+/ur5WFZn3z8GY6FSvXk
 ZANUX3x6tzYeqO7715fn0cQ9L5BZlzx5JqqYVDotaWxSs8q+ukKz6vbJGqNulenCnT95wcDOu
 fb/6RmYWzTAPLVpv44PMsfQe10S52P9t9Nv1OjW8/pfvIMObhWLzM6MbMLgmbhk63pRe9mXUb
 897s79htsTTweXHFSzhBxzxBuTgwHY8r7eVu38W/Xu0sP9xytOj7tj7Duz075b6TRm2LS/l3Q
 ftQ5+g==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 02:40, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>   drivers/video/fbdev/omap/omapfb_main.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

applied.
Thanks!
Helge

>
> diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbde=
v/omap/omapfb_main.c
> index 17cda5765683..1f3df2055ff0 100644
> --- a/drivers/video/fbdev/omap/omapfb_main.c
> +++ b/drivers/video/fbdev/omap/omapfb_main.c
> @@ -1447,7 +1447,7 @@ static int fbinfo_init(struct omapfb_device *fbdev=
, struct fb_info *info)
>   	info->fbops =3D &omapfb_ops;
>   	info->flags =3D FBINFO_FLAG_DEFAULT;
>
> -	strncpy(fix->id, MODULE_NAME, sizeof(fix->id));
> +	strscpy(fix->id, MODULE_NAME, sizeof(fix->id));
>
>   	info->pseudo_palette =3D fbdev->pseudo_palette;
>
> @@ -1573,8 +1573,7 @@ static int omapfb_find_ctrl(struct omapfb_device *=
fbdev)
>
>   	fbdev->ctrl =3D NULL;
>
> -	strncpy(name, conf->lcd.ctrl_name, sizeof(name) - 1);
> -	name[sizeof(name) - 1] =3D '\0';
> +	strscpy(name, conf->lcd.ctrl_name, sizeof(name));
>
>   	if (strcmp(name, "internal") =3D=3D 0) {
>   		fbdev->ctrl =3D fbdev->int_ctrl;

