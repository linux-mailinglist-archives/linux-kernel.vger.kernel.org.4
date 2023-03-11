Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202CC6B572A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCKA4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjCKAzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:55:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0339912B94D;
        Fri, 10 Mar 2023 16:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1678496005; i=p.jungkamp@gmx.net;
        bh=qMpEJq9/VDvSbq1BxRMreV5rXJDYdI69qmniBXaW75w=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=iPM1hIpLIhXNQTTlyUBg7uUZMyo5kc55l9ZcYRu+TRQ1SNYhiPd/vbFtQ9WyMmm+O
         Kmka98vWWOSes3mzkAupeu8v0qkbIDznC4wDJzi2UW1nLq+GKsj94kS3+yBLHBYfTC
         A5qePmK1uhpZmv2QqTATN4xYHP7AFu3cKEJ+v1ndyZBUNkZscIxgO4OVqe2q8QQxA9
         3GqDOs/dTvfBVeaMPBkOuFWIgKsHQZuXdkUHS9zCAomiXRi7LeB66VrjTtk43siZgp
         oOdNYM7xEj2TOTxSg/a3ZGZKcU5l5KrWB/5TJ61wbQAJfC61V91QKjaefdoL1bNd6w
         36JYFtZhKwPVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.149] ([93.238.84.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNp7-1qHKRs0eKr-00lo4I; Sat, 11
 Mar 2023 01:53:25 +0100
Message-ID: <b9dab02783e5eeaa74b291d4394150689e7c7b8a.camel@gmx.net>
Subject: Re: [PATCH] Fix buffer overrun in HID-SENSOR name.
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Todd Brandt <todd.e.brandt@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     todd.e.brandt@linux.intel.com, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, jikos@kernel.org
Date:   Sat, 11 Mar 2023 01:53:22 +0100
In-Reply-To: <20230310235414.12467-1-todd.e.brandt@intel.com>
References: <20230310235414.12467-1-todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Provags-ID: V03:K1:UFBI+T9+hsbH1HXtKgbA99vW4viypL7GZykNMrSy9AtQFwvxKkD
 jH/PUmPhuFJS7uRjqwAY6Eaa92tFaJ09P9UObRKk2LFccjOo72wp6BYyMPCaiTtvYMv5GUQ
 4CcuNtK5a3pzvCa4LlviZ/3MFv4dZgurw9ovLWgJ5YdXycAWVSLzgk5nsG2dY5omWScuQXr
 GfzhLGoVXdWb6QiY4MrTw==
UI-OutboundReport: notjunk:1;M01:P0:KvHxAsUbBT0=;Bs55vAzkdWdYKlzJpu8nVHXaUJW
 ZmWPk/lfKyqOffe4NQ3ZDyMMHIGbzVCOldAagid+/9S7cbSO087Y4IeHKjWdl1tob0X6ZAg80
 EnqmJJD7lNYdztwLjb/JCVOkl7z/LLXs8qn8WxG6nInNqB4TV3w76uZfjHAMCIv4nDjOJv+HK
 pQ/Zhe7nVIppINpmSfyEeAJsgiTrDcOy2zEO0VRIZ2iocfBz7ZB6APGVkVHXhrIOZnCJp4g+n
 9IfQ95CrZRHH1sM6S3PrAc/HuuN56fULuLvM7m09vLTdi8dafounb8LKP8bRzD/Oyx268wvLo
 iP0HxIKNzG2+cnEevKzckSw9HfFD4A7Wl1FIiKECO/QeTl3x9AeU1KOVC0zscvu6JFAVDMwYx
 Hfj4lNhVpF5NwiYDJIM8l/iMuV3mUwxSUhXyM4b34F5sJIWyr6Ll1sLZ4lYe/2lsu+jfposmz
 STDXEoFGu922RIJ6yDhCgA24xkv2GEzZsDT38V9Foc9/EcgQyFmtZqYr3fXi8D97iTxe9byFC
 M5eUoabcaCoeFpaMGLZvWSJd/qzb8N2crbUCAYpOxhlDlKl8cgI7ViucPJxFr/Emqx10yIAkS
 gYd4fPQcc8SEmvauj0cY8xCkCvraa2VfTyEk29bFLWgwSek62TcjlSb980ZhZ4R4OSsESxheo
 N4HAAvayy0gOIoDDaE2MQbDRUmOjxmWES7SU40ryjjb5mrvWoq6kjST5UaYCtUCHOKgrBlHrG
 KPKZiEorVMuuHXooTI5/BsoCLFI7oIeaaN5vcrMTYqBKp18nvYNBVmF1fhXmijySYVxUCA2zl
 strD7ygUhiZMzVFuHkMK+XLg6bedoetHeHjQYpLdatg3qJjszdI6S5RcUrNw9YPZ7NwoZ/Okg
 soutaLWjvnMaM6N4NkV42vJAvnaDh4l5/2tZH0GFCmu4jdiFonUtY6KZylxiEoJZrSJjrdfEU
 dnwRFQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is exactly the fix I proposed. Thank you for testing and properly
submitting it.

Regards,
Philipp Jungkamp

On Fri, 2023-03-10 at 15:54 -0800, Todd Brandt wrote:
> Philipp Jungkamp created this fix, I'm simply submitting it. I've
> verified it fixes bugzilla issue 217169.
>=20
> Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217169
> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> ---
> =C2=A0drivers/hid/hid-sensor-custom.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index 3e3f89e01d81..d85398721659 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -940,7 +940,7 @@ hid_sensor_register_platform_device(struct
> platform_device *pdev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hid_=
sensor_hub_device
> *hsdev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struc=
t
> hid_sensor_custom_match *match)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char real_usage[HID_SENSOR_USA=
GE_LENGTH];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char real_usage[HID_SENSOR_USA=
GE_LENGTH] =3D { 0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct platform_device *c=
ustom_pdev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *dev_name;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *c;

