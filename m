Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7166AA0D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjCCVJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCCVJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:09:22 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1759860D70;
        Fri,  3 Mar 2023 13:09:19 -0800 (PST)
Received: (Authenticated sender: dodji@seketeli.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 592651BF206;
        Fri,  3 Mar 2023 21:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seketeli.org;
        s=gm1; t=1677877758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cv66zFFxlrbcWbvrnbTnad6WW7AbCdUiUsmIER3GGNo=;
        b=VJ3mH6zdWteY8M4XC4ovydcmbhNtEm1vA24Iv/QkNqJXO8RZpPW1T7U0bgq0raGYksTqtt
        RLPkBW5UVyKF3rL2oSwz0sy91JQzNeAugxrnzxtmaBo6wElmPyvJhp6IgSNe284tAEYuID
        p6r4YlwLtc8wfKWWJrGt46K9Od8MJJCQNL5K7eFmbaA4gdt/gJcSCHU7mLqk8NDhpiQFI1
        viL6RZSpzLJi2mhYHneDXdI/M439SUELnvFcSwddbX6WinC0J4gnxPltN98lnelSo71nV3
        1A8IAeBQ2AyVH2MPJ5zsJhbpkM2JTsR+rUOwWyV8q8uoTsxvj06aAn5K977Pvg==
Received: by localhost (Postfix, from userid 1000)
        id 4FFA9B4E34; Fri,  3 Mar 2023 22:09:11 +0100 (CET)
From:   Dodji Seketeli <dodji@seketeli.org>
To:     John Moon via Libabigail <libabigail@sourceware.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        John Moon <quic_johmoo@quicinc.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v2 1/2] check-uapi: Introduce check-uapi.sh
Organization: Me, myself and I
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
        <20230301075402.4578-2-quic_johmoo@quicinc.com>
X-Operating-System: CentOS Stream release 9
X-URL:  http://www.seketeli.net/~dodji
Date:   Fri, 03 Mar 2023 22:09:11 +0100
In-Reply-To: <20230301075402.4578-2-quic_johmoo@quicinc.com> (John Moon via
        Libabigail's message of "Tue, 28 Feb 2023 23:54:01 -0800")
Message-ID: <87zg8t5yq0.fsf@seketeli.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John,

John Moon via Libabigail <libabigail@sourceware.org> a =C3=A9crit:

> While the kernel community has been good at maintaining backwards
> compatibility with kernel UAPIs, it would be helpful to have a tool
> to check if a commit introduces changes that break backwards
> compatibility.
>
> To that end, introduce check-uapi.sh: a simple shell script that
> checks for changes to UAPI headers using libabigail.
>
> libabigail is "a framework which aims at helping developers and
> software distributors to spot some ABI-related issues like interface
> incompatibility in ELF shared libraries by performing a static
> analysis of the ELF binaries at hand."
>
> The script uses one of libabigail's tools, "abidiff", to compile the
> changed header before and after the commit to detect any changes.
>
> abidiff "compares the ABI of two shared libraries in ELF format. It
> emits a meaningful report describing the differences between the two
> ABIs."
>
> The script also includes the ability to check the compatibilty of
> all UAPI headers across commits. This allows developers to inspect
> the stability of the UAPIs over time.

Thank you for working on this.

The libabigail bits look good to me, for what it's worth.  I just have
some general considerations to discuss.

[...]

> +# Perform the A/B compilation and compare output ABI
> +compare_abi() {

[...]

> +	if "$ABIDIFF" --non-reachable-types "${ref_header}.bin" "${base_header}=
.bin" > "$log"; then
> +		printf "No ABI differences detected in %s from %s -> %s\n" "$file" "$r=
ef" "${base_ref:-dirty tree}"
> +	else
> +		# If the only changes were additions (not modifications to existing AP=
Is), then
> +		# there's no problem. Ignore these diffs.
> +		if grep "Unreachable types summary" "$log" | grep -q "0 removed" &&
> +		   grep "Unreachable types summary" "$log" | grep -q "0 changed"; then
> +			return 0

There is no problem in parsing the output of the tool like this.
However, the return code of the tool has been designed as a bit field that
could be analysed to know more about the kind of changes that were
reported: https://sourceware.org/libabigail/manual/abidiff.html#return-valu=
es.

Right now, there is no bit assigned to detect new types (or interface)
addition, but do you think that it would be a helpful new feature to add
to abidiff for this use case?  We can discuss this in a separate thread
if you prefer, so that we don't pollute others with this minutiae.

> +		fi
> +		{
> +			printf "!!! ABI differences detected in %s from %s -> %s !!!\n\n" "$f=
ile" "$ref" "${base_ref:-dirty tree}"
> +			sed  -e '/summary:/d' -e '/changed type/d' -e '/^$/d' -e 's/^/  /g' "=
$log"

Here again, if you'd like to have a particular output format emitted by
the tool, we'd be glad to discuss how to improve the plasticity of the
tool enough to emit the right output for you.  For instance, we could
add a new --no-summary that would let the tool display the change
directly without the summary header that you are strimming out with this
sed script.

[...]

Thanks again for this tool that I think might be very useful.

Cheers,

--=20
		Dodji
