Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391B87111D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbjEYRSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjEYRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E9B6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE90647B8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C925C433EF;
        Thu, 25 May 2023 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685035081;
        bh=01eRIOZ7bYxYaUdJayYuJzz1CMZSZWiRLMpxEYaraRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deDxfVQ/lRbxnPB3XmXYbvjtgu3esTjjcfVUBzWOD8usSF6+iJgOiN9Ihnj/iJeeJ
         SoXOQTbMhM7Aciq3YfZ8zPDgxS7Gcgrhiw0od2BJ22IrZ5P8pNBzOVED8owFrPIxF5
         55HRuoHYzJ2KnS0ETYRn1vkQjCv7am6wrFcR76UPQPCVld4SYhktoD3TLGp7vIagfe
         vwD4saFF28KvbpnlPXz0APK/7ST4Oi+iGnUvPsBx+iyhSnzsMThky2PcF9DhOmY13u
         7SWKcLW48eQ1+UKZkUakRtab3KggYl/nFm+uXpmcx7wbwmA2RMf55zjfeUQZIgmT3b
         +ts5J2Oq3a11Q==
Date:   Thu, 25 May 2023 18:17:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 RFC Zisslpcfi 15/20] sslp prctl: arch-agnostic prctl
 for shadow stack and landing pad instr
Message-ID: <8ed76335-f87f-42e7-85b0-94a6e2b2cc3f@sirena.org.uk>
References: <20230213045351.3945824-1-debug@rivosinc.com>
 <20230213045351.3945824-16-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vm+ay5gteDFPAYRx"
Content-Disposition: inline
In-Reply-To: <20230213045351.3945824-16-debug@rivosinc.com>
X-Cookie: Your step will soil many countries.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vm+ay5gteDFPAYRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2023 at 08:53:44PM -0800, Deepak Gupta wrote:
> Three architectures (x86, aarch64, riscv) have announced support for
> shadow stack and enforcing requirement of landing pad instructions on
> indirect call/jmp. This patch adds arch-agnostic prtcl support to enable
> /disable/get/set status of shadow stack and forward control (landing pad)
> flow cfi statuses.
>=20
> New prctls are
>       - PR_GET_SHADOW_STACK_STATUS, PR_SET_SHADOW_STACK_STATUS
>       - PR_GET_INDIRECT_BR_LP_STATUS, PR_SET_INDIRECT_BR_LP_STATUS

FWIW I had something very similar in my in progress arm64 support for
GCS (our equivalent feature), though without the LP stuff as we don't
have that.

Reviewed-by: Mark Brown <broonie@kernel.org>

I'll pull this into my branch and redo things on top of it if that's OK,
seems sensible to avoid collisions/duplication?

--Vm+ay5gteDFPAYRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRvmEQACgkQJNaLcl1U
h9DOfgf5AcCEl1dHBhGVUZq2+USwzCjItL+iBBoYEIXuo4NGV8wdR+Tw8uzRNp2+
d8kPCAXVYTYqlVVa3mWVVq+ERkiThqk6y4g78/Atj0eOeBF8sWjSsJelSe8uCvIR
Id3zGELslcknllMUj/uQcsSIZJ6Sk/sdZmD8gmi3ai+DuxEiHiD4stZQgsasGxdj
uSHKvSxUj5C3A1+GNEqPeWSS8JVllNbtoWwJE5KqSL+FCSSW/JzPpUvE+TD+jJKy
bD9BFOIrXcz8R+D/VedYQstC7CaV0k3szsGWryl5Ja/5ORQu8KbxwS7DbZYkLsWM
aCg4iyY9LlLy+4GwFokt4gmFe79c1A==
=epZt
-----END PGP SIGNATURE-----

--Vm+ay5gteDFPAYRx--
