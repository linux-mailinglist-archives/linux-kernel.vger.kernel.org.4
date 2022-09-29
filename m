Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543355EEC79
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiI2DaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiI2D3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:29:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517A1C43F;
        Wed, 28 Sep 2022 20:29:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id jm5so123959plb.13;
        Wed, 28 Sep 2022 20:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=WBLQeUiWrXR3Z7msbrDY/7CaG4wrpqUAwf6qrwrbU6A=;
        b=VxSOGrGjbA/bYJRf7pHU3BC22kHB1pCeeLw3QZX/r/gwtuobatc9b3InephBeK8K3v
         w4tChFV/yUPzFfdG83fKKERSkBKdGs0WWGMJWrZ9tXgCDGFekP1cdSNk+5H9AdgArbeO
         7iaL05JZpCirdpaONrompU6L8t6bBQycDJnsluRsP2NJzRYGJx9OkCr8GNwbuNgFhv4L
         yJUJpKf3PD2IjeDGHnmdcKBdeZh+jC+ngl5c6QJcy815d+4dujgMXs50CTPUd3DWKha+
         taMUS3Es0LknaayEHmKb0znQTdFlKh6wPgVZOFxP0B235AxBWZxok8y004oynCYztULf
         sC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WBLQeUiWrXR3Z7msbrDY/7CaG4wrpqUAwf6qrwrbU6A=;
        b=qSv3dImV2v+bm/CX+5yuGS2swlSqio/6uY3fk7zV8n0oDRGsQJWuicjpTUFtMm6XlY
         QHr8XSsnykZWC91jd3dKIZYq3wGII1VJ7XjmreOzWGWAk3ktdV94wb5W4xa1XAMBqXDp
         +q0i5R/sxRSzzGHWd8lroY1ZWQlW4U008Ko79VckmbcQS4ArySZ9bVWL44zq5tTJF2vl
         xoC/xtYkjS/i+AH9IWorHBsNKFZRwdUqsbJ3JH0zypkknfuYWv1+DlIi35ulezxFWuOf
         uJuozW9ru6Ffqxaq0esDZimAK3zxdnzNMtj+Ot269EKSMzq47EeX4Y/UJ/G7d5dZIrdw
         Us/g==
X-Gm-Message-State: ACrzQf1c4v2FoRQ0OQINDbsCB0VnKDGgz8NGycYbmQhnQLLM6QoiwB5C
        hFGo+wAzlU6el2iBR+GZZys=
X-Google-Smtp-Source: AMsMyM6AhuzBvnqb70L2tjG7p4gnIj3jE1w61YnXwy3QXbd9/cDs27XZOTWJTOQPOJoPhkBE+KfmAw==
X-Received: by 2002:a17:902:ecca:b0:179:f3a3:11ae with SMTP id a10-20020a170902ecca00b00179f3a311aemr1336780plh.32.1664422186142;
        Wed, 28 Sep 2022 20:29:46 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-79.three.co.id. [180.214.233.79])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b00177f4ef7970sm4650993plg.11.2022.09.28.20.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 20:29:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 76D49109240; Thu, 29 Sep 2022 10:29:41 +0700 (WIB)
Date:   Thu, 29 Sep 2022 10:29:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/4] serial: Convert serial_rs485 to kernel doc
Message-ID: <YzURJa1RnxP+uj5/@debian.me>
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
 <20220928110509.13544-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K1U/UeAdAUv32+TP"
Content-Disposition: inline
In-Reply-To: <20220928110509.13544-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K1U/UeAdAUv32+TP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 02:05:06PM +0300, Ilpo J=C3=A4rvinen wrote:
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index cea06924b295..6e347eb10b1f 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -107,37 +107,57 @@ struct serial_icounter_struct {
>  	int reserved[9];
>  };
> =20
> -/*
> +/**
> + * struct serial_rs485 - serial interface for controlling RS485 settings.
> + * @flags:			RS485 feature flags.
> + * @delay_rts_before_send:	Delay before send (milliseconds).
> + * @delay_rts_after_send:	Delay after send (milliseconds).
> + * @addr_recv:			Receive filter for RS485 addressing mode
> + *				(used only when %SER_RS485_ADDR_RECV is set).
> + * @addr_dest:			Destination address for RS485 addressing mode
> + *				(used only when %SER_RS485_ADDR_DEST is set).
> + * @padding0:			Padding (set to zero).
> + * @padding1:			Padding (set to zero).
> + * @padding:			Deprecated, use @padding0 and @padding1 instead.
> + *				Do not use with @addr_recv and @addr_dest (due to
> + *				overlap).
> + *

I don't see definition of fields after @delay_rts_after_send in the
htmldocs output.

>   * Serial interface for controlling RS485 settings on chips with suitable
>   * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by =
your
>   * platform. The set function returns the new state, with any unsupporte=
d bits
>   * reverted appropriately.
> + *
> + * serial_rs485::flags bits are:
> + *
> + * * %SER_RS485_ENABLED		- RS485 enabled.
> + * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
> + * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after sent.
> + * * %SER_RS485_RX_DURING_TX	- Full-duplex RS485 line.
> + * * %SER_RS485_TERMINATE_BUS	- Enable bus termination (if supported).
> + * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
> + * * %SER_RS485_ADDR_RECV	- Receive address filter (enables @addr_recv).
> + *				  Requires %SER_RS485_ADDRB.
> + * * %SER_RS485_ADDR_DEST	- Destination address (enables @addr_dest).
> + *				  Requires %SER_RS485_ADDRB.

The last two items are rendered as bold text instead (maybe due to missing
fields rendering above?)

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--K1U/UeAdAUv32+TP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzURHwAKCRD2uYlJVVFO
o8zJAQDrJlHQQ8z/otn+Vn3JTSypBOX/wYulcrUjC3PCnmS62QEAhw9oX9TDlsT7
SHsIcotFsXnBGmqvABQh60L3fA9uJAM=
=M/47
-----END PGP SIGNATURE-----

--K1U/UeAdAUv32+TP--
