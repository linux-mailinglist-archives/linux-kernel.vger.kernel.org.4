Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765F874E006
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGJVKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGJVKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:10:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF44BF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:10:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b9e93a538dso4924295ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689023407; x=1691615407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxBgucAbBdu0IzJonXBaaKE77FkZJQjZWz7yflbR3Ws=;
        b=rHgtS9tMj+PbfaQLlrrBQbvkMdvBFt5ZvHKTP+rf8glkYTJzb1ZdarorF6EPAHbVav
         qJ5XYOFijpSg4tyJtyd2aVpHOgqpwp4VsbxLGWRRVvqZa9SV1lbVd/YtqQ4Oz0GMfkvp
         9O+YnNsc9l1AT5CwORqAFoa6+HlXIj/Z+Bt3qdb5bsS31jzoy6cCxpiUsBhuaPoaVTGg
         0u8pY04x0/OOEtP1YqRtPNOBrhyhh8GJ/8fi1LucB2i1M3LYL3hw7MsF2cMM9x2fampG
         JEFBVPT8J/o2VtrZMIF5WK7UWhR9Y/tr3DvvfeRcC1CTkxgVjr83LA7ZH3FwUJGMcVvL
         SpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023407; x=1691615407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxBgucAbBdu0IzJonXBaaKE77FkZJQjZWz7yflbR3Ws=;
        b=Qxj3Y/m4IC788Zn95dkT8/8Df9k2QK9qX3N6WSC6/21Pn3VPt4ugxTHdEO7+R1Gk+k
         zlPgn6MBwHFT7YapmR/ksh+WfpncM5/9x/+CAvmaPP5WJdY7M/Dinf3e8to5pNEaqVlx
         hMjcAlbbXgXvXB0blIOEgDppLp3g8cp8W1XLwaLEL9XUtFpmUXJ2DEoANVKz6OL6d21d
         ga5rHZqGsxbj5vU05i8P3GT3WqCRjU5ZMvAMoZvJz3oKRES94MrJ6Cfhg22+tRHEB+9d
         y0ufiCujN7zf/9r1oDiaLVkfgPzgduCjT8ecKMTWUaOSWpaaZAJP7GmZfDaGdR2YDJpe
         APpA==
X-Gm-Message-State: ABy/qLaVO8W50d5ev6ok81RXHdkAh8o382iDb+bCdOcDvuRskNMcXEYE
        lAOo0xXHHD0NCVjRxpnLyQmb1A==
X-Google-Smtp-Source: APBJJlFN4CnA+xw8gns+5xtyY+OarOimOqCe+0/1XFT/cP1AmHbHUV+69BPWQLLeu4oeslpGzj/6mQ==
X-Received: by 2002:a17:903:124a:b0:1a9:40d5:b0ae with SMTP id u10-20020a170903124a00b001a940d5b0aemr12439810plh.12.1689023407417;
        Mon, 10 Jul 2023 14:10:07 -0700 (PDT)
Received: from fedora (61-114-134-192.ppp.bbiq.jp. [61.114.134.192])
        by smtp.gmail.com with ESMTPSA id bg5-20020a1709028e8500b001b6740207d2sm317657plb.215.2023.07.10.14.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:10:06 -0700 (PDT)
Date:   Sun, 9 Jul 2023 21:07:33 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Anh Tuan Phan <tuananhlfc@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org, rongtao@cestc.cn,
        ricardo@pardini.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/counter: Add checking directory exists for make
 clean
Message-ID: <ZKtZ1WB9LdszbxU+@fedora>
References: <362e127d-6018-5fc6-247b-3c729b99d946@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RmzhX0RDy1psNxnS"
Content-Disposition: inline
In-Reply-To: <362e127d-6018-5fc6-247b-3c729b99d946@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RmzhX0RDy1psNxnS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 09:08:35PM +0700, Anh Tuan Phan wrote:
> rmdir requires the directory exist so it causes "make -C tools clean"
> failed if someone only builds other tools but not counter. This commit
> adds checking the directory exist before doing rmdir.
>=20
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
>  tools/counter/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
> index a0f4cab71fe5..2907f3b3094b 100644
> --- a/tools/counter/Makefile
> +++ b/tools/counter/Makefile
> @@ -40,7 +40,9 @@ $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
>  clean:
>  	rm -f $(ALL_PROGRAMS)
>  	rm -rf $(OUTPUT)include/linux/counter.h
> -	rmdir -p $(OUTPUT)include/linux
> +	@if [ -d $(OUTPUT)include/linux ]; then \
> +		rmdir -p $(OUTPUT)include/linux; \
> +	fi
>  	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>=20
>  install: $(ALL_PROGRAMS)
> --=20
> 2.34.1

Hi Anh,

Please CC <linux-iio@vger.kernel.org> and <linux-kernel@vger.kernel.org>
as well in the future so Counter users and developers can become aware
of relevant patches.

One worry I have with this approach is the possible race condition where
the check for existence succeeds but the directory is deleted by another
agent before our rmdir executes. However, I'm not sure how we could
achieve such behavior atomically to prevent the issue.

One alternative I've considered is perhaps a single find command to
search for and delete empty directories:

    find $(or $(OUTPUT),.) -type d -empty -delete

But this will delete directories not created by the makefile which I
consider an unexpected behavior for the user (or at least very rude of
the script to do).

Perhaps we should delete the directory tree explicitly:

    rm -df $(OUTPUT)include/linux
    rm -df $(OUTPUT)include

Although we lose the symmetry of rmdir to our previous mkdir, this
should prevent the race condition issue and succeed whether the
directories still exist or not.

William Breathitt Gray

--RmzhX0RDy1psNxnS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZKtZ1QAKCRC1SFbKvhIj
K4hDAP9w2c3wZQu+EpvAt5WwqtMUX274NPd/BV+5v07V9USGIgEAwJY9F1i1y9Qr
pnnk74zbTZhPXXWYTjkMS/oICurGbAw=
=E0Ch
-----END PGP SIGNATURE-----

--RmzhX0RDy1psNxnS--
