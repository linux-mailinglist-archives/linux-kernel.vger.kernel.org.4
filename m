Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626855E92B9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiIYL0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIYL0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:26:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E2518388;
        Sun, 25 Sep 2022 04:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664105181;
        bh=49VdDnQFxc/vEg9QiBmQxGXhsqXNNFtIXiRzbT/Yf1M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cmubWN1F35JAhLZVOCWE8L668RVF0aRkLjxQ9ks5noJJUeBauh0i/fZlf0fzSGP6Z
         JzRAzVFPgybJF2DsBU0Cw5LK+TBbhsWjObpwvFuXX6muolhT0lKJjdBZLvLLVd2N1U
         DyblofhMsM7It4FD4PlX51vptjfgHm+1uEH3tmug=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.188.118]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1omd2W0tV7-00Rreo; Sun, 25
 Sep 2022 13:26:21 +0200
Message-ID: <9534d64c-0236-29db-4e15-860d458207c8@gmx.de>
Date:   Sun, 25 Sep 2022 13:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] video: fbdev: gbefb: Convert to use dev_groups
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, broonie@kernel.org,
        maarten.lankhorst@linux.intel.com, daniel.vetter@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220902025555.3833920-1-jiasheng@iscas.ac.cn>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220902025555.3833920-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CbGdJazMXcBcACvJwi7UoeY+qSb8dv4KFFaaWwGSQtND2V8usUE
 wpmM08CNu21olSuvvtu0O5vkJ0wp4Mt70YSG01LlQgRinNxy4twf08zyhC6FHpdUkZ+OQuw
 j2ewYfOs54eJgkMhmtEmx9hvo2++91EXkUbaSdm7SXmHxFuXFb6saJVu6aTvXbO3yXl7xeD
 G5BIZMFhNggXh0dxIFRrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MIyQ6NQJXVQ=:Ilj+gC5t8BmnPvRgepsffD
 cIon+lC5duC4ldFv6uM9EPIA+al2rIe5oEw4CGV/GsCGOAEu67dsojqrwxvrL29yFVO49+BFn
 uCQ35Xok/c2+g/BJNtf7Zon2JSK1bn51f+2fqt/GaXdjrWqErTwdH+aRfAXWSdrf5mlKx1pM1
 0kKWAkGZre28f2qURrshPghQGZHEdP/s9+vxg0OhgmwkZ1VCa+97sOmj0GyQ1Jk85e9sPdQVR
 ZPllX5T5cxWEcgjIgBak2WRydRCv0dNTha8JdLkBg70R2ESzPY3EzPcMMPZJJmi1JsfwM1jGO
 vrcvX1CuIn8eU6aeUALqaFD0sOb7vHLu3MngnteF9qrir30MfcgwPDl4Vbnv9mQ5WxYJSgt9j
 OeUPqPUTLaNP47OJXQznAVdj5AgvqqvbIU33WHIkcW55iEc7h0P8nS1KSLAOPI7kf/hekWbr0
 UGEwkFlEE7C7KNZbVcHRmNS4/M5Dxc+ArTO60ypEcDE8QwyWW3F7e0VbyOYiYrg1Qxou3yNSa
 QVtGExh4oNr5sg08Q7FJ4DKz8ZaumUptCJsOYSjMuR28Nx25Nr/oWO2oRPXVZmj3O5h/9TDl7
 oJI0/3ro+SJxKmqXyhf++ZHqkvbW7wrMlJo4WELqmXkusgMGX1pVpG+CCruG93VsuTba45M+C
 Wp2n15OLJghKYO/Qtsn7OaTqSqX5jKxcHPY1ZX3eWReE8JeH8dSeea5kdSrnIFNczWQfCfnJI
 27H6hhF/OFTCigMaFQIzR3EJOW2w4JiY6H1srPf8wX6k5bDhq33ISPH/e/FlMFHbyyGp4nUhL
 6PrbA3RCv7KQTru/0Ag3LzliIOMn7xVseKIWvDgNZHrehvtIPQTy+aAOxkBgBbE5+LEYc173z
 /krRE1Hu+C5YZ1/7Ga99HccKIZAcTgAL3scJz7xDMMBndjSzz4yo+dnqu1KDei0nlmm+aGWhF
 33F9ukSinXRLANoeflxCJXuV0ktvhNGdBZqpF03cmBd1gDBpkyKIQaR5TDn5chMfZwxBoNgY+
 ITwofqGORtjVBwJFQ0d9pOrBTYcdVw8zxoOdi/azYEbgoZrkeb2IM9zPf7oZsD7yNqZ3kRfeT
 +h5SrdI5+FM/Lm7KzzvS5g3oe/01REWkOLgdfPCJZy/UfXqEJSj49ZTcDz5tN7/YHbTetU7dO
 PPoaVO57vh/LvZFuXR9gK7Ttii
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 04:55, Jiasheng Jiang wrote:
> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner. Moreover, it can
> guarantee the success of creation. Therefore, it should be better to
> convert to use dev_groups.

applied. Thanks!

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This Fixes: lines doesn't make sense.
I dropped it.

Helge


> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/video/fbdev/gbefb.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
> index 6b4d5a7f3e15..1582c718329c 100644
> --- a/drivers/video/fbdev/gbefb.c
> +++ b/drivers/video/fbdev/gbefb.c
> @@ -1072,17 +1072,12 @@ static ssize_t gbefb_show_rev(struct device *dev=
ice, struct device_attribute *at
>
>   static DEVICE_ATTR(revision, S_IRUGO, gbefb_show_rev, NULL);
>
> -static void gbefb_remove_sysfs(struct device *dev)
> -{
> -	device_remove_file(dev, &dev_attr_size);
> -	device_remove_file(dev, &dev_attr_revision);
> -}
> -
> -static void gbefb_create_sysfs(struct device *dev)
> -{
> -	device_create_file(dev, &dev_attr_size);
> -	device_create_file(dev, &dev_attr_revision);
> -}
> +static struct attribute *gbefb_attrs[] =3D {
> +	&dev_attr_size.attr,
> +	&dev_attr_revision.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(gbefb);
>
>   /*
>    * Initialization
> @@ -1221,7 +1216,6 @@ static int gbefb_probe(struct platform_device *p_d=
ev)
>   	}
>
>   	platform_set_drvdata(p_dev, info);
> -	gbefb_create_sysfs(&p_dev->dev);
>
>   	fb_info(info, "%s rev %d @ 0x%08x using %dkB memory\n",
>   		info->fix.id, gbe_revision, (unsigned)GBE_BASE,
> @@ -1248,7 +1242,6 @@ static int gbefb_remove(struct platform_device* p_=
dev)
>   	gbe_turn_off();
>   	arch_phys_wc_del(par->wc_cookie);
>   	release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
> -	gbefb_remove_sysfs(&p_dev->dev);
>   	framebuffer_release(info);
>
>   	return 0;
> @@ -1259,6 +1252,7 @@ static struct platform_driver gbefb_driver =3D {
>   	.remove =3D gbefb_remove,
>   	.driver	=3D {
>   		.name =3D "gbefb",
> +		.dev_groups	=3D gbefb_groups,
>   	},
>   };
>

