Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9AC5F8B9B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJINn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 09:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJINn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 09:43:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DFAF79
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:43:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 67so8709826pfz.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/lTQ0ECNC3oK37T953kXua5zG5HMxyVr5V/xIfmkn0=;
        b=MQyMLWRQPEWRFY/nFk6S/xhxuudLKI+Sm0PFzSfHdBbO32ROUxlcMPMOw0PdUn0Rd0
         IpARQEbQHn4RNsQKocGVt8X/6SMf7SuhwSHTU+WoMxTF25aTN3H8mJLzvry4V9X7qNi1
         9akAigGnK7YOk2ryapzriCAuEAydeH/YyJWMjg6+8NPAmMbMmJmVZtpbA1oKk+E+DbBM
         feM5HQOzgsWtdb68AKzPe7WkVWMWu2soZ1ZceLtHKlcZWYz+axZK8tO97BDNZOwvJ3t4
         SY4tPgPbgj7DA+eK0oeCePfzJ821NZViDhcIFIpBfGZPvRhd/7kzET7BKYwJ+zOOvhrP
         xqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/lTQ0ECNC3oK37T953kXua5zG5HMxyVr5V/xIfmkn0=;
        b=I2hFvU+w7zOHmwcpTKsM8xWji5Nwj2Z9GESVtRBPFWfPVdovl+ECLL+mP7FV73sm7+
         YhPRGLR5FMEVAZNRvbZ7AdawBxTAIkEma3W+c1ekhWr2/P5yBuctCx052Mu+Ni2zHCNt
         yJ1voCZC5kAwGZaNmMdl9P3c/I38AsQfQrX13IK3XYKDPGC6w0NaKTOPRywkZNQJ1Tqj
         oVmbbR7nFix7kviPW3rGJU7d++H0/CblrQkCKN35iQMdm15UdB+/XyjAwDz+ZSFlfxHB
         ell5UCOtpqdcXWVGweZusYsVMSw9fMacNcr+QUwNDkGl+FYhFNnP7MVre2NAqRb6Ns3u
         2dDA==
X-Gm-Message-State: ACrzQf0cbgau0lb5wVxrBs9hrxgrNDafn0Ms6rifnWZSL61SR0M4zBMj
        v91xtiLXnw8E45VaZg17jua5CNC8rDnlqw==
X-Google-Smtp-Source: AMsMyM4k4J/QjWx5A7FH69byuVDvsLl4j/CjsQHTMtPNJhDrG/R93TXwFxSJq8wM0mv7XdqxGvfs2Q==
X-Received: by 2002:a62:144b:0:b0:562:38de:9a0e with SMTP id 72-20020a62144b000000b0056238de9a0emr14858223pfu.78.1665323035247;
        Sun, 09 Oct 2022 06:43:55 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b00178b06fea7asm4757208pli.148.2022.10.09.06.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 06:43:54 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CC85D1039BF; Sun,  9 Oct 2022 20:43:51 +0700 (WIB)
Date:   Sun, 9 Oct 2022 20:43:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] ring-buffer: Fix kernel-doc
Message-ID: <Y0LQF02sKheWtkD8@debian.me>
References: <20221009020642.12506-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YH9GWmnykX8Ccsn+"
Content-Disposition: inline
In-Reply-To: <20221009020642.12506-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YH9GWmnykX8Ccsn+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 09, 2022 at 10:06:42AM +0800, Jiapeng Chong wrote:
> kernel/trace/ring_buffer.c:895: warning: expecting prototype for ring_buf=
fer_nr_pages_dirty(). Prototype was for ring_buffer_nr_dirty_pages() instea=
d.
> kernel/trace/ring_buffer.c:5313: warning: expecting prototype for ring_bu=
ffer_reset_cpu(). Prototype was for ring_buffer_reset_online_cpus() instead.
> kernel/trace/ring_buffer.c:5382: warning: expecting prototype for rind_bu=
ffer_empty(). Prototype was for ring_buffer_empty() instead.
>=20

Describe what this patch does to fix these warnings. Remember to write
in imperative mood. (Actually I figured out what you are doing, see
below).

> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D2340
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Get rid of the parenthesis.
>=20
>  kernel/trace/ring_buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c3f354cfc5ba..199759c73519 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -885,7 +885,7 @@ size_t ring_buffer_nr_pages(struct trace_buffer *buff=
er, int cpu)
>  }
> =20
>  /**
> - * ring_buffer_nr_pages_dirty - get the number of used pages in the ring=
 buffer
> + * ring_buffer_nr_dirty_pages - get the number of used pages in the ring=
 buffer
>   * @buffer: The ring_buffer to get the number of pages from
>   * @cpu: The cpu of the ring_buffer to get the number of pages from
>   *
> @@ -5305,7 +5305,7 @@ void ring_buffer_reset_cpu(struct trace_buffer *buf=
fer, int cpu)
>  EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
> =20
>  /**
> - * ring_buffer_reset_cpu - reset a ring buffer per CPU buffer
> + * ring_buffer_reset_online_cpus - reset a ring buffer per CPU buffer
>   * @buffer: The ring buffer to reset a per cpu buffer of
>   * @cpu: The CPU buffer to be reset
>   */
> @@ -5375,7 +5375,7 @@ void ring_buffer_reset(struct trace_buffer *buffer)
>  EXPORT_SYMBOL_GPL(ring_buffer_reset);
> =20
>  /**
> - * rind_buffer_empty - is the ring buffer empty?
> + * ring_buffer_empty - is the ring buffer empty?
>   * @buffer: The ring buffer to test
>   */
>  bool ring_buffer_empty(struct trace_buffer *buffer)

Oh, these warnings above are due to mismatched function name, right?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--YH9GWmnykX8Ccsn+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0LQFwAKCRD2uYlJVVFO
o8HKAP460IufdwWV8co3egGjt7J15uH6orDk7k2t8ftPF74EBwEAhS8C1XK/9ihJ
CVgn1cZRCN39cfVjldh6jYnG4tu5nAQ=
=3LtU
-----END PGP SIGNATURE-----

--YH9GWmnykX8Ccsn+--
