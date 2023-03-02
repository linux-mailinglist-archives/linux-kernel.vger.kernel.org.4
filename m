Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4396A79AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCBCsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCBCsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:48:17 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B346A78;
        Wed,  1 Mar 2023 18:48:17 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id cp12so8494795pfb.5;
        Wed, 01 Mar 2023 18:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677725296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyOJjljScA1IV8sLYQx4JYgQ0KEeCcbRmuPAm8zbNs0=;
        b=mqEVhSLhnIWUxSLG5tX+ddyDaOLKKTszF/OvzkWpp0mmPCBVwGSAZ03nEog087YXvK
         8y6FRPNHQVQi/1MVYt6xZh0q5sg6+MMle8H+cvhkUBCzSvZ4W9EL2WcmCpbJ/EGiwtHW
         2RuOiWxHNT3jUhP55yFCFzSg2n91EU1U3Z2BPZIOY2fLNAKay12PEMb951JwQasrVNyw
         I5yp7q8ohmPyZMD4DOhSffVKrj1YLrKu9GV/ae9xINgwN0lyJyps52J7X9dohThl60mc
         w8BPHcq7Tcb0E8i7IKMDIPULkASD/uRgPYWYrxbYPTgAXiEDLPWdDnnJgvI5eH4EQ24m
         rg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677725296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyOJjljScA1IV8sLYQx4JYgQ0KEeCcbRmuPAm8zbNs0=;
        b=t9v2SJcNVKex8EZ8YqwqtUY6eopiEe/Du++4l0oDCvFSjSHg+uJQ1z0G0nD+/u+W8Y
         rz+uqqAo3NtbdaRrzbWarSJptnhu+AfdWTZG9T5iDgvVbhZWdW8jyvnuyCNlhCsFa2Mh
         ts5z55Jc5wNor6URv3X2pbU1NEOzV3CCcOaIKtiVTQZLtTZT9ynCuIaDf9gaOlGAIIWO
         jdIv26yQu/52Zvrueupd7Cb/OKV46hoE+kLn04k8TImxGwlQDnl6lH3B7Uks3gGos5Q7
         u5B2iOrQ5Ql23vbXGvAiDLw8u0EdrG1xT5qrsOkt8nKo4by+xc0KzJpp14ppYTvYxL05
         IOqQ==
X-Gm-Message-State: AO0yUKVn2mkCTk4MOH/kFiS+jvyyhuxOZ4aqvz62/5Bf9TPOiD4Rvial
        sV/CtK9288abcboTYJhy7R0=
X-Google-Smtp-Source: AK7set+SCS9iuszLb29lf2dM6thcXWIzqM012j7t5hexSTRJVB9F7PoLom1itM2jWwAmZhOkIFBnQA==
X-Received: by 2002:a62:6401:0:b0:577:272f:fdb with SMTP id y1-20020a626401000000b00577272f0fdbmr7021473pfb.29.1677725296570;
        Wed, 01 Mar 2023 18:48:16 -0800 (PST)
Received: from debian.me (subs32-116-206-28-6.three.co.id. [116.206.28.6])
        by smtp.gmail.com with ESMTPSA id x21-20020aa793b5000000b005a8de0f4c76sm8873813pff.17.2023.03.01.18.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 18:48:14 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 8BCA0104006; Thu,  2 Mar 2023 09:48:11 +0700 (WIB)
Date:   Thu, 2 Mar 2023 09:48:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, wang.yong12@zte.com.cn
Subject: Re: [PATCH linux-next] delayacct: improve the average delay
 precision of getdelay tool to microsecond
Message-ID: <ZAAOa4nYSYQc48Lr@debian.me>
References: <202302131408087983857@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8wLeOCCbXvPi5D5N"
Content-Disposition: inline
In-Reply-To: <202302131408087983857@zte.com.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8wLeOCCbXvPi5D5N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 02:08:08PM +0800, yang.yang29@zte.com.cn wrote:
> From: Wang Yong <wang.yong12@zte.com.cn>
>=20
> Improve the average delay precision of getdelay tool to microsecond.
> When using the getdelay tool, it is sometimes found that the average
> delay except CPU is not 0, but display is 0, because the precison is too
> low. For example, see delay average of SWAP below when using ZRAM.
>=20
> print delayacct stats ON
> PID	32915
> CPU             count     real total  virtual total    delay total  delay=
 average
>                339202     2793871936     9233585504        7951112       =
   0.000ms
> IO              count    delay total  delay average
>                    41      419296904             10ms
> SWAP            count    delay total  delay average
>                242589     1045792384              0ms
> This wrong display is misleading, so improve the millisecond precision
> of the  average delay to microsecond just like CPU. Then user would
> get more accurate information of delay time.

I'm kinda confused. 0.000ms is same as 0ms, right?

And did you mean accuracy of delay average is to be same as CPU time?

--=20
An old man doll... just what I always wanted! - Clara

--8wLeOCCbXvPi5D5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZAAOZAAKCRD2uYlJVVFO
o6xvAP0WSORel6xyIqLGNu4/4lTlk9PRFn7O/lcP8vrG6NhNuwEAxqqncRwHWDwo
QhdxwBIWfmACP0vVmaSxBU121++GiQQ=
=1hUB
-----END PGP SIGNATURE-----

--8wLeOCCbXvPi5D5N--
