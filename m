Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A427420D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF2HPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjF2HPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:15:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AF2270E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:15:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so415742a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688022927; x=1690614927;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a3GaODHqyz8EaU1i9tzLMXM+YZJuaG2YGtGjPE377s=;
        b=zV0JJtvZ3kr8Gv3PdjQ3YlxUxpN6m7iBEVAsi5BLYnhFbPzGPNRRlttZHiUfF7bfrn
         TiazErVVdXZf6u/3rfGt8AjA7XfFqaj7FPoRHkOcSunTeByj5qKE2cQRrWhPFt8WHeP6
         55KUrZccZmUDbRz3QbmumipbKCicoAtbFZQpAQXvG0VVuNCwPUULDbhOKwKlThdATuDE
         UuOANvKzy9ZgqhVbWXPXJGnWH68M4Slr7OwDbZXItbXeM2bufQT3RchRj78/l7dUfyX4
         CC4WBUiR1jtZp7ANlZW2d9oxeTGI7j4s/SJTfRokzVTiNspRPG43dzCzgxH1wSJhZNl8
         PVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688022927; x=1690614927;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7a3GaODHqyz8EaU1i9tzLMXM+YZJuaG2YGtGjPE377s=;
        b=IzGpCGLGDB0QaO4wjYar/SJRyc096nwtwdNH0rcDDlINxRo43HDCO8djk8XHm/R+Ov
         1xYqQyvyRJa5ZKd8ss+ESuME1k8pznXANPzF0zoi8eHuOJTQxwwNV2/B64fPEg1a8joL
         ficJbPVGrfY6xYtUHM/95SRnzz9gyGcOkmlXpuPTESmfI1HF9zN4kYVdLQA96jSnTpc6
         9aOrArE7gegnbm08S5muw8jg4ULh1FXU92u3ij1IAmDVhMI9vlsyRKLYT4OKCGcF7iR8
         My7m4BsmsTuQGq+uUXisblb2U9RKUbRibMAMxjQZoNMaeK+WmBgtb0K7Ep2XoP5u9s+b
         QIZw==
X-Gm-Message-State: AC+VfDzYiOeFq2Z/w8Y5QPMbryAyAQgP3v5h7UUeA6MXKB/8vnLW2Tex
        GSQ/MZb8u6WBxqj0QGRg8Qlo8w==
X-Google-Smtp-Source: ACHHUZ7tLTwjqC9/cnSRrVf/XVIql3aF69KAHHFQ0NxTAM1WlIaC6Cm2NM71A3Rw+EEBWyGR9OC15w==
X-Received: by 2002:a05:6402:799:b0:51d:893c:60c3 with SMTP id d25-20020a056402079900b0051d893c60c3mr9385931edy.9.1688022927225;
        Thu, 29 Jun 2023 00:15:27 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7c98d000000b0051dd4daf13fsm776212edt.30.2023.06.29.00.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:15:26 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-2-nmi@metaspace.dk>
 <d23bf48c-5bc9-aab6-4ca2-ebbb24a0878e@kernel.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 1/4] ublk: change ublk IO command defines to enum
Date:   Thu, 29 Jun 2023 09:11:15 +0200
In-reply-to: <d23bf48c-5bc9-aab6-4ca2-ebbb24a0878e@kernel.org>
Message-ID: <875y76zqlv.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien Le Moal <dlemoal@kernel.org> writes:

> On 6/29/23 04:06, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> This change is in preparation for zoned storage support.
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  include/uapi/linux/ublk_cmd.h | 23 +++++++++++++++++------
>>  1 file changed, 17 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd=
.h
>> index 4b8558db90e1..471b3b983045 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
>>  	__u64   reserved2;
>>  };
>>=20=20
>> -#define		UBLK_IO_OP_READ		0
>> -#define		UBLK_IO_OP_WRITE		1
>> -#define		UBLK_IO_OP_FLUSH		2
>> -#define		UBLK_IO_OP_DISCARD	3
>> -#define		UBLK_IO_OP_WRITE_SAME	4
>> -#define		UBLK_IO_OP_WRITE_ZEROES	5
>> +enum ublk_op {
>> +	UBLK_IO_OP_READ =3D 0,
>> +	UBLK_IO_OP_WRITE =3D 1,
>> +	UBLK_IO_OP_FLUSH =3D 2,
>> +	UBLK_IO_OP_DISCARD =3D 3,
>> +	UBLK_IO_OP_WRITE_SAME =3D 4,
>> +	UBLK_IO_OP_WRITE_ZEROES =3D 5,
>> +	UBLK_IO_OP_ZONE_OPEN =3D 10,
>> +	UBLK_IO_OP_ZONE_CLOSE =3D 11,
>> +	UBLK_IO_OP_ZONE_FINISH =3D 12,
>> +	UBLK_IO_OP_ZONE_APPEND =3D 13,
>> +	UBLK_IO_OP_ZONE_RESET =3D 15,
>> +	__UBLK_IO_OP_DRV_IN_START =3D 32,
>> +	__UBLK_IO_OP_DRV_IN_END =3D 96,
>> +	__UBLK_IO_OP_DRV_OUT_START =3D __UBLK_IO_OP_DRV_IN_END,
>> +	__UBLK_IO_OP_DRV_OUT_END =3D 160,
>> +};
>
> This patch does not do what the title says. You are also introducing the =
zone
> operations, and the very obscure __UBLK_IO_OP_DRV_XXX operations without =
an
> explanation. Also, why the "__" prefix for these ? I do not see the point=
...
> Given that this is a uapi, a comment to explain the less obvious commands=
 would
> be nice.

It is a little vague, I'll make sure to include a better description =F0=9F=
=91=8D

>
> So I think the change to an enum for the existing ops can be done either =
in
> patch 2 or as a separate patch and the introduction of the zone operation=
s done
> in patch 3 or as a separate patch.

I agree, the zone ops should not be introduced in this patch, I will
move them to patch 3. That is a mistake.

Best regards,
Andreas
