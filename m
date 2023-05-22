Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5470C4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjEVSCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjEVSCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:02:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836C115;
        Mon, 22 May 2023 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684778548; i=deller@gmx.de;
        bh=XYc624rp14uGmFw7V+RpipNyamXCae8xWBesq8Wzch0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DWELf+f1QYUtiGgVl5LdIGZNeQtZw/3/B/ta4721hkXhpkgxodim8XgtQu7P4omRO
         iVyF1ZAfkgQ2walLIawUlQao+VouRtOkfXNqtP3Mx4wKjdM7JpU4VPfuAlayiEe6Cz
         TFGdsYLaRnW0Pwqo0QShTphJutAYcVh02ZtWfoma4SpBCa261bC0SQadFQQxk8/4Ur
         YKij4AdNhChzXXZ7ZzUinkDTe1dTrt/5pG2QGwD4t3jhDZ2P/8kExrIte9Kb/JrSRU
         oEjtkKGMqaTN4Qb0nnITvW1pmGlro6zoYyHqrkpQ+7rmIyF73N0HKlxO5EhcdBjAoB
         iLLHhvNUYtKhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQXH-1qJVj72W5V-00sJVb; Mon, 22
 May 2023 20:02:28 +0200
Message-ID: <069f2f78-01f3-9476-d860-2b695c122649@gmx.de>
Date:   Mon, 22 May 2023 20:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] video: imsttfb: Fix use after free bug in
 imsttfb_probe due to lack of error-handling of init_imstt
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Zheng Wang <zyytlz.wz@163.com>
Cc:     alex000young@gmail.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        1395428693sheep@gmail.com, tzimmermann@suse.de
References: <20230427030841.2384157-1-zyytlz.wz@163.com>
 <34gbv2k3lc5dl4nbivslizfuor6qc34j63idiiuc35qkk3iohs@7bshmqu2ue7a>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <34gbv2k3lc5dl4nbivslizfuor6qc34j63idiiuc35qkk3iohs@7bshmqu2ue7a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PfUYXpvWMuOOsXD6z6hDlW4zxrijkqWNQR241XhkbgwSYYR5Exs
 vrMLbqYn9c07gDe+BfLpK2gCSZS7DmcraMknMA/rUrhNqJtJN2o1tWSIdTXmMqdtye1G7B7
 cSuZie+oPXJKuG1OJTM8gF4898l9XlKuOme30KDYWJU//wQItJGL7P3mKmVLJ8TaTQOmduF
 0F9E2t038ndH4jxFPkLeg==
UI-OutboundReport: notjunk:1;M01:P0:u/iktjswmR0=;QcgsMcSYN+1sr1fnL/z4Bk3Ctn5
 9f9SghE3HCO1+MHOIOchWMM4GzgxwChhr0Drb3ZsSMP0Ker/pbbSSXiIkTrFDumbYXegUcOW1
 J46ZMmEzpo0Z1UBqtDGvs3iy7y6XfLZNq4IeIl5WNLh+R83gdMGmCYcLEng5ixVSxukwv2FFQ
 VCsbf/O430+FerLasWH0a+O3ufcBF7DvhMMrSAxg75J9izRDV54DZf6AJ05aDOakd5aBspkWb
 sVDEYNZQUTkkOz/EyP/Gdk9Casuws2/LpOYfWyrwADGSwYnNP6wuqgOsVQv/Hk3BIXnPP7EtN
 i0c1QWm/tSlRSzv1ZfutOJ7PfhxFH9C9uojSM2xsiA1e37s3UqQXfT56zxxgK0hCB5fCLWdFV
 3eDiK5oT1W3cCVQ2uSZwDVh2FHNuMj5qPeZrPFscPSFJypjfCjohoFi/FL+AlXO+3TAW7/Sri
 pdiZa+h+Q24UTBmW/3KmZ/S3NhOcdWpcZT/Zx9RFj5RXkmLQOIRWknlj14C3POpRftz0rQ1Kc
 s9XeBdsLQVmxTNOSU/Ash1t17GhucMmpMm4HUI4mOONAU3CaMRWw3f3ScOYfexojrPg2C/SZ3
 SQS838AT8msUxN+Y3JCtz6vr3rESONTp0PpPfa0HgHF5Ne3DUE2UQkXFOrvB1a+o6DQPQFc47
 PU3PhMh60ygwDe5OB118et7FKXZb+/UDIsVjiJnEYDeK9uWiQpoiu5sO5k6eJWY7iMs36OJFH
 t59wldh+YPiV9FSzXtQMklufhpOxh5RsYVA2CjEy/0PDqpS5kAMFEyLY4CvwOBjscRAroph6i
 RniI9PwpC4JS8ZlmMu66ulrhAyraP1zYRCWLpnv1cfwfk8OAumJ4zPk9+ALULDohE5FbqJMTr
 rG0XxMu6RhxFdeNw/7YSrncx4WbjFc8HVT/msNy++JobkWKLZhWx8wbQztnqZMDhhrBfO7/XJ
 hdbNHA==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 5/22/23 17:36, Michal Koutn=C3=BD wrote:
> On Thu, Apr 27, 2023 at 11:08:41AM +0800, Zheng Wang <zyytlz.wz@163.com>=
 wrote:
>>   static int imsttfb_probe(struct pci_dev *pdev, const struct pci_devic=
e_id *ent)
>> @@ -1529,10 +1530,10 @@ static int imsttfb_probe(struct pci_dev *pdev, =
const struct pci_device_id *ent)
>>   	if (!par->cmap_regs)
>>   		goto error;
>>   	info->pseudo_palette =3D par->palette;
>> -	init_imstt(info);
>> -
>> -	pci_set_drvdata(pdev, info);
>> -	return 0;
>> +	ret =3D init_imstt(info);
>> +	if (!ret)
>> +		pci_set_drvdata(pdev, info);
>> +	return ret;
>>
>>   error:
>>   	if (par->dc_regs)
>
> This part caught my eye -- shouldn't the -ENODEV from init_imstt go
> through the standard error with proper cleanup? (It seems like a leak
> from my 30000 ft view, i.e. not sure about imsttfb_{probe,remove}
> pairing.)

Yes, you seem to be right.

> Shouldn't there be something like the diff below on top of the existing =
code?

Yes, but ....


> Regards,
> Michal
>
> diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb=
.c
> index 975dd682fae4..a116ac8ca020 100644
> --- a/drivers/video/fbdev/imsttfb.c
> +++ b/drivers/video/fbdev/imsttfb.c
> @@ -1419,7 +1419,6 @@ static int init_imstt(struct fb_info *info)
>   	if ((info->var.xres * info->var.yres) * (info->var.bits_per_pixel >> =
3) > info->fix.smem_len
>   	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres)))=
 {
>   		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->va=
r.yres, info->var.bits_per_pixel);
> -		framebuffer_release(info);
>   		return -ENODEV;
>   	}
>
> @@ -1455,7 +1454,6 @@ static int init_imstt(struct fb_info *info)
>   	fb_alloc_cmap(&info->cmap, 0, 0);
>
>   	if (register_framebuffer(info) < 0) {
> -		framebuffer_release(info);

That's ^^^  ok, but I think a
	fb_dealloc_cmap()
is missing here ...

... and in the error path of imsttfb_probe() ....

>   		return -ENODEV;
>   	}
>
> @@ -1531,8 +1529,10 @@ static int imsttfb_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
>   		goto error;
>   	info->pseudo_palette =3D par->palette;
>   	ret =3D init_imstt(info);
> -	if (!ret)
> -		pci_set_drvdata(pdev, info);
> +	if (ret)
> +		goto error;
> +
> +	pci_set_drvdata(pdev, info);
>   	return ret;
>
>   error:

Would you mind sending a proper patch?

Thanks for noticing!
Helge
