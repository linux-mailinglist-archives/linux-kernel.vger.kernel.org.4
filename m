Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA646F9053
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjEFHpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjEFHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:45:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216803AAE;
        Sat,  6 May 2023 00:45:22 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52c759b7d45so2328047a12.3;
        Sat, 06 May 2023 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683359121; x=1685951121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cR4QBIzm9ikJ2rDEayugYqmQh2EvvMkSbIdL6X+oqsg=;
        b=NDFMhb8dgFmBZE3tzcTfHyrvdARzyBDs68HVUrFHKNB1OjppTHcturM01pjQGR1lwf
         /Yyj38mcOgdR7rJvMgtexY8VUeSE9mCjrLHOXK9r+ljtXsToQ1AuwIIohZc/qYXw5lQX
         AuWzIqHmM99Ek3TBL43g3uK5sVlNrLjjSuGi6E5Av3n/YiQvm1NafwCsxs/Tttjc3MNf
         kndOlzMpilSI8aWvGjWtCBkxkt2m+9a+4r74hawaf/fn1Q17c3W3ID1fguszSj+BLcZf
         Ln3qJl6tIKqhxkPKKjAgr2BjL3Jybxttwo/q/4nXrE/J34Rpq9nbqwmZ/QJSIgGx2Ywn
         LNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683359121; x=1685951121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR4QBIzm9ikJ2rDEayugYqmQh2EvvMkSbIdL6X+oqsg=;
        b=UMeQdd2RlXa69OYerW1xJbZhX7BD4XTGO0FQSCaorB0zHJeDz5HzNETm7XIJsS9JDq
         HLt3UkxdK4si3MR0HwzXzutdFCORSi+001lf9pVo+CD2dy575D2X7xmQ9R5tcilOz0Q2
         MF2oSH/JRNpVASKeDj43kAe42RcG1Rkt+qiZlW9qn87chU9UT+vFOs0XEjbZ6UzHN/YW
         CJRScsHl7+UmGkoQPnROVTFuYtaPbiq878ejA2tjjUPBTVxMo2evEGStTgL4Bb4Hqpl/
         vcKQPFiWJyzoDCSC0+F6kkFJwYzRCx7WdgnBeg+j/AqeLUBu0oIehI5ktF/z7HWX8+Ks
         b/Tw==
X-Gm-Message-State: AC+VfDzGqc71a+3uqXx4fxDzQOA4c7CHbdIDGyBBDL96IyeFGkaG/4/q
        NKcO1RMNL/nD7echYHQZgPc=
X-Google-Smtp-Source: ACHHUZ42rj/cGI3yidLvMVSMoh1eSdorzn60Wv53lamvefOOxDdlc+3RCuNWWWGYKa/CqamDoXSI6Q==
X-Received: by 2002:a17:902:e881:b0:1a6:b140:9d2 with SMTP id w1-20020a170902e88100b001a6b14009d2mr4758930plg.61.1683359121362;
        Sat, 06 May 2023 00:45:21 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902759100b001ab0672fc1fsm2955359pll.105.2023.05.06.00.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:45:19 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C0A98106286; Sat,  6 May 2023 14:45:15 +0700 (WIB)
Date:   Sat, 6 May 2023 14:45:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, dhowells@redhat.com,
        jarkko@kernel.org, corbet@lwn.net, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Documentation: Security: Consistent block output by
 removing a misfit line
Message-ID: <ZFYFi+eS3efdx0jS@debian.me>
References: <20230506033738.16908-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rGslkIUOaY9i4+kT"
Content-Disposition: inline
In-Reply-To: <20230506033738.16908-1-unixbhaskar@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rGslkIUOaY9i4+kT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 09:07:38AM +0530, Bhaskar Chowdhury wrote:
> -	[root@andromeda root]# cat /proc/key-users

You remove the command line, right? The preceding sentence should be
adjusted too, e.g. "This file lists the tracking data (including
quota information and statistics) ... . Example file contents::".

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--rGslkIUOaY9i4+kT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFYFhAAKCRD2uYlJVVFO
owlmAQChZDiqGOaRj7Jhi2fE/wNTF/sPW4oXVkaredS4EqlrkAD/aO2lQsDZtyUC
VzZRSAXUIAnpIg6TLHX6uae7UadMMAg=
=VC5A
-----END PGP SIGNATURE-----

--rGslkIUOaY9i4+kT--
