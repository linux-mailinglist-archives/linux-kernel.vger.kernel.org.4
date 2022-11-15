Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A139D62998C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiKONEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKONEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6014262E8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668517428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwFTRSjvBq3e+IXuQuSlNARebSjDFofjy3AIZnLKcDs=;
        b=DI+U5LtGZm3xOiD2I4bTT8BmbqY9OGzGS2tcBxmtwFVDeiRPMPRCrN7Q4BxyD7bnRDN+N+
        shCbyCxqvQqqunvWUD2xIIZfAnJr12DexEVr6tVc6Yr3Fn7v58PLQ6lmPdBfByLELZaGiv
        HV41aH8+gPZb1iD5ZAD/MMAD5bGdfjk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-38-zfSXipZ5MMqObdXHCPJPiw-1; Tue, 15 Nov 2022 08:03:47 -0500
X-MC-Unique: zfSXipZ5MMqObdXHCPJPiw-1
Received: by mail-qt1-f197.google.com with SMTP id ay12-20020a05622a228c00b003a52bd33749so10089524qtb.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwFTRSjvBq3e+IXuQuSlNARebSjDFofjy3AIZnLKcDs=;
        b=KoT2EEZgbD5vkuiaF4IDVaPhYmn6FHQlrZDca/LcAQ2D7EW9pU9+z1N3fcdaE6BIFD
         03tC2NGTRGA92KEdSXn4n8LScxkHzv4O4axUBFbt/An5xr5d7v5gkDEalnsMo1AmzObg
         aQ8Jx3fy1LHN1G7V1JTR9TrF9WN4oMujMfgwoatc/9JQAMS1WSGUQAcpggSzDiVNWTK9
         nphh3pq0ySKng81kzstdH5wyaZOoqQgX8eWUu+FFdEURReGX5cz6m81VV23DmDzIXXE8
         2koFHdodMO5CoCty2e8yo6On4NEXlMcogl7kTx6AGRb9ghmrw6G/5pD5tvddjgbnTOLV
         7FGA==
X-Gm-Message-State: ANoB5pmNY35BEWAaVUrW1aiXKAwdjbuHUFh8GqkBs43iZwmSMYeCl848
        /fh3BsF29XwdQYiooCvaUd0wvoTV2hm2jUoFV8OwL87LTDKbDk/gIH+5HHK6MtbRRukpkf4M5Nu
        pmuVp7ld1ExIuIjSM/mTdA98a
X-Received: by 2002:ac8:4415:0:b0:3a5:2556:42ed with SMTP id j21-20020ac84415000000b003a5255642edmr16135257qtn.422.1668517426809;
        Tue, 15 Nov 2022 05:03:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6g4wONIalNVue6tn6WP7hXmPOBZBfpwYnNOhI3Rflggb5LyweprHhYoAyHIk52G5OdRUrCgA==
X-Received: by 2002:ac8:4415:0:b0:3a5:2556:42ed with SMTP id j21-20020ac84415000000b003a5255642edmr16135238qtn.422.1668517426562;
        Tue, 15 Nov 2022 05:03:46 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id o26-20020ac8699a000000b003a50b9f099esm7112858qtq.12.2022.11.15.05.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:03:46 -0800 (PST)
Date:   Tue, 15 Nov 2022 08:03:45 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>, andersson@kernel.org,
        sboyd@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: gcc-sc8280xp: add cxo as parent for three
 ufs ref clks
Message-ID: <Y3OOMXZBvew9eg9T@x1>
References: <20221115102217.6381-1-quic_shazhuss@quicinc.com>
 <Y3OLDj6xzOVjvEdV@x1>
 <Y3ONkOhcdK+gt46g@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ONkOhcdK+gt46g@hovoldconsulting.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:01:04PM +0100, Johan Hovold wrote:
> > Put this Link beneath the --- since Bjorn will add one that's specific
> > to your patch when he adds it to his tree.
> 
> I think it's ok to keep that Link if it was intended as a reference to
> the discussions leading up to this patch. There can be more than one
> Link tag, and this one is more in line with how Linus thinks they should
> be used than the ones added by tooling such as b4 when applying.

OK, good to know. Thank you!

Brian

