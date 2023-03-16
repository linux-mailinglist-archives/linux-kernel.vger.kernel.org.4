Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA276BD7DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCPSLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCPSLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:11:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669DAC489D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:11:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so1787816wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678990272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ7M3gShi7OPBMSsQz15sNK2ZIdo5mI3mjzNWeh8fLM=;
        b=epUnK/mVWXZpqStsZ0w9F9Ud3iGd5aPhDsRi8YIoAftKUCXacXQIcfFaXmnKy3+uuA
         0tlODxwV5XSsoK5HJt/jzWS/IZAyqCAlupsyVUJFboVsQReIgvf1E7meWkgIoz1EH0cu
         v+sExBPDOUP+SVCfpqSG91Z5gFA7ctNwKMGxMaAb9Y93d6g/dd3feXx+GkS1bLxCiWY2
         qIMRETqSyP9o/GB9tkjv8WbWboj5O0LPpfG+jncHOXU3SJ/FFUS0rMR2Ci2ppYrj2Kja
         NIezRzWLR6k8+8p0PminbEs8vn7pBRBVX4oOjTpkbSz+BaXcmV+3kHXmPHj3wwO7me5I
         Q46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQ7M3gShi7OPBMSsQz15sNK2ZIdo5mI3mjzNWeh8fLM=;
        b=N0ZEGrkV4PHydkLzaw7gl9QVoZTcHQgJaw1BIyi5+wF+9dAm4FKOwjEmniGYyur0uD
         9CK44VR4GFliJFUUNRWEmOPqwONoU1TWMSUs81NkFWnk6S7bvrzB1ZOfGGGZAzhryrXb
         rPQa5NTwSN+o0k5o8ksv4WSXcY3lS0vziywM9RbAn+UtRZiwMcPFvC2CrFN++gVb5bZ+
         8UnPeI1cOatUVQ3jGKMDEx1UUcJJwsSyOZl7JSrgi290Fse4Rjdm5IrXXZixViCE4jQA
         WfgYsH9aYITsf3RiXkxdgDDtten05Asm3Y9sE22p3XqreBcHwdzh231+lnqNJFTPsp1i
         sUaQ==
X-Gm-Message-State: AO0yUKVK7GAXyJx9t2gYHL7hGqdY4MW/Ye3MWr1JiI1Vcv5r7YfkMLge
        S6w2HmPwH9T4VU91SiaiOkv4LkNGjos=
X-Google-Smtp-Source: AK7set+BHEbi2h07a2oFa3Wz9zKkyzwEGG6Z71DNK0LGKaxRtsLLMTw5Z3WBd/l1Zab1c9vMbFn8lg==
X-Received: by 2002:a05:600c:474d:b0:3eb:39e2:915b with SMTP id w13-20020a05600c474d00b003eb39e2915bmr21505718wmo.31.1678990271722;
        Thu, 16 Mar 2023 11:11:11 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c2cae00b003df5be8987esm5826865wmc.20.2023.03.16.11.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:11:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy@lists.linux.dev,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] staging: axis-fifo: initialize timeouts in init only
Date:   Thu, 16 Mar 2023 19:11:09 +0100
Message-ID: <2552330.Lt9SDvczpP@suse>
In-Reply-To: <ZBNDJwFHE3vIFS3+@khadija-virtual-machine>
References: <ZBNDJwFHE3vIFS3+@khadija-virtual-machine>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 16 marzo 2023 17:26:15 CET Khadija Kamran wrote:
> Initialize the module parameters, read_timeout and write_timeout once in
> init().
>=20
> Module parameters can only be set once and cannot be modified later, so we
> don't need to evaluate them again when passing the parameters to
> wait_event_interruptible_timeout().
>=20
> Convert datatype of {read,write}_timeout from 'int' to 'long int' because
> implicit conversion of 'long int' to 'int' in statement
> '{read,write}_timeout =3D MAX_SCHEDULE_TIMEOUT' results in an overflow.
>=20
> Change format specifier for {read,write}_timeout from %i to %li.

It's good that you added this line. I had missed it :-)

> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>=20
> Changes in v6:
>  - Initialize module parameters in init instead of probe function.
>  - Change the subject and description
>  - Change format specifiers of module parameters to "%li"
>=20
> Changes in v5:
>  - Convert module parameters's datatype from int to long.

NIT: "parameters'", not "parameters's".

>  - Link to patch:
>  https://lore.kernel.org/outreachy/ZBMR4s8xyHGqMm72@khadija-virtual-machi=
ne/
>=20
> Changes in v4:
>  - Initialize timeouts once as suggested by Greg; this automatically
>    fixes the indentation problems.
>  - Change the subject and description.
>  - Link to patch:
>  https://lore.kernel.org/outreachy/ZA4M3+ZeB1Rl2fbs@khadija-virtual-machi=
ne/
>=20
> Changes in v3:
>  - Correct grammatical mistakes
>  - Do not change the second argument's indentation in split lines
>=20
> Changes in v2:
>  - Instead of matching alignment to open parenthesis, align second and
>    the last argument.
>  - Change the subject and use imperative language.
>  - Link to patch:
>  https://lore.kernel.org/outreachy/ZAxNYw2rFQkrdtKl@khadija-virtual-machi=
ne/
>=20
> Link to first patch:
>  https://lore.kernel.org/outreachy/ZAZSmPpB6fcozGa4@khadija-virtual-machi=
ne/
>=20
> drivers/staging/axis-fifo/axis-fifo.c | 28 ++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c
> b/drivers/staging/axis-fifo/axis-fifo.c index dfd2b357f484..0a85ea667a1b
> 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -103,17 +103,17 @@
>   *           globals
>   * ----------------------------
>   */
> -static int read_timeout =3D 1000; /* ms to wait before read() times out =
*/
> -static int write_timeout =3D 1000; /* ms to wait before write() times ou=
t */
> +static long read_timeout =3D 1000; /* ms to wait before read() times out=
 */
> +static long write_timeout =3D 1000; /* ms to wait before write() times o=
ut */
>=20
>  /* ----------------------------
>   * module command-line arguments
>   * ----------------------------
>   */
>=20
> -module_param(read_timeout, int, 0444);
> +module_param(read_timeout, long, 0444);
>  MODULE_PARM_DESC(read_timeout, "ms to wait before blocking read() timing=
=20
out;
> set to -1 for no timeout"); -module_param(write_timeout, int, 0444);
> +module_param(write_timeout, long, 0444);
>  MODULE_PARM_DESC(write_timeout, "ms to wait before blocking write() timi=
ng
> out; set to -1 for no timeout");
>=20
>  /* ----------------------------
> @@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char=20
__user
> *buf, mutex_lock(&fifo->read_lock);
>  		ret =3D wait_event_interruptible_timeout(fifo->read_queue,
>  			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -				 (read_timeout >=3D 0) ?
> -				  msecs_to_jiffies(read_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			read_timeout);
>=20
>  		if (ret <=3D 0) {
>  			if (ret =3D=3D 0) {
> @@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const=
=20
char
> __user *buf, ret =3D wait_event_interruptible_timeout(fifo->write_queue,
>  			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
>=20
>  				 >=3D words_to_write,

NIT: I don't really like this split of the second argument into two lines.=
=20
This line may look too long, but I don't think that it should be split. I=20
prefer to read=20

"ioread32(fifo->base_addr + XLLF_TDFV_OFFSET) >=3D words_to_write,"

However, the final decision is up to Greg.

If he takes the code as is, I have nothing against.=20
Don't send any other version unless required by Greg or other Mentors with=
=20
more experience than I have.

All the rest look good... well done!

Reviewed-by: Fabio M. De Francesco

Please feel free to forward my tag if you are required to change that line =
and=20
send a new version.

Thanks,

=46abio

> -				 (write_timeout >=3D 0) ?
> -				  msecs_to_jiffies(write_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			write_timeout);
>=20
>  		if (ret <=3D 0) {
>  			if (ret =3D=3D 0) {
> @@ -948,7 +944,17 @@ static struct platform_driver axis_fifo_driver =3D {
>=20
>  static int __init axis_fifo_init(void)
>  {
> -	pr_info("axis-fifo driver loaded with parameters read_timeout =3D %i,
> write_timeout =3D %i\n", +	if (read_timeout >=3D 0)
> +		read_timeout =3D msecs_to_jiffies(read_timeout);
> +	else
> +		read_timeout =3D MAX_SCHEDULE_TIMEOUT;
> +
> +	if (write_timeout >=3D 0)
> +		write_timeout =3D msecs_to_jiffies(write_timeout);
> +	else
> +		write_timeout =3D MAX_SCHEDULE_TIMEOUT;
> +
> +	pr_info("axis-fifo driver loaded with parameters read_timeout =3D %li,
> write_timeout =3D %li\n", read_timeout, write_timeout);
>  	return platform_driver_register(&axis_fifo_driver);
>  }
> --
> 2.34.1




