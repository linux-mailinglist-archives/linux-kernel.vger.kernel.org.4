Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA68A6249C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiKJSni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiKJSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:43:30 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2236305
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:43:28 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id l2so2177183pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4y0f1haOhrPBjhGk8rnlTxBOovrLu+sXTKkXLaTe0c=;
        b=JNjyUycW4m606iWp2ge3v+WkMxXT+wEHq8Rr+OTk2iXrhBTtzuLAVPxRXCRiUQJIat
         e3okiB424bY0sw378TE/cl3qKMCevLRTDk2JlZMS1ZUFkQGqyVjI1gbY5qjQL3WJIPkA
         m875at0R7T8174/R+LHWWoBuI5BSrAlyHlRY0mHc26ZAlisuO8iLt59+dfjwAHVnffBL
         tJfOyuZuKPB2wi+m28nNLeCuFFaXysC71zBBJOUusnQ23C/k7ZPjQCfmlUZmSTZ8dGle
         ePu/lVnDcce3fBcpgKYfrVKiSgs9SEKgDp5FNPQGR8eNTZpGB6DcGn4XuVnIx1RB6Vnq
         ZczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4y0f1haOhrPBjhGk8rnlTxBOovrLu+sXTKkXLaTe0c=;
        b=ouGL8C8wfKTGVA9hLXeWfRP13/7wolEnRLKelBzj55N154Bev3fk/jz0Fz7SenY2N2
         ZvNb0JlyvR53tgycbN73JIiXS3JeteCIlJ9i7NKK4aFDrKuvZXYBC9sdj7L+OZn6aMkw
         S5gkBZesoA2YVNqO7syPeFkk5efZF/N35DxoN8UJ/66tXFc8d0CSJMQgoQbSPKSfPvdW
         2/KC1180c6kBJe7cv4BoDXpR/P1Cz03eBCwgXs/yb37R4RMqUytoW11vsm7NXndmU9Xg
         Goxrdxqri6NAYb/pkpzU36hEIbpAtF05CVb5F0AfBszxFoKWro8lc5GeGbwIOQRKPdNV
         e9Mg==
X-Gm-Message-State: ACrzQf0FQfbTC0844pmoBmlNk15TG9oNgSB1wcDtd11sVonHALpkyIzs
        1BzGznOvM2cbeDehsicj5uQ=
X-Google-Smtp-Source: AMsMyM7Aem+H9YdrwsIErn0vugtUXbZgJqxUJ2j8nJvc1wHy/3yKsiUDsGB3L/gvNRQK02zxFUjbvg==
X-Received: by 2002:a17:902:bb8a:b0:185:378d:7c2a with SMTP id m10-20020a170902bb8a00b00185378d7c2amr1719987pls.127.1668105808082;
        Thu, 10 Nov 2022 10:43:28 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709027ec100b00186cf82717fsm6409plb.165.2022.11.10.10.43.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Nov 2022 10:43:26 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] mm/uffd: Sanity check write bit for uffd-wp protected
 ptes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221110151702.1478763-3-peterx@redhat.com>
Date:   Thu, 10 Nov 2022 10:43:25 -0800
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ives van Hoorne <ives@codesandbox.io>
Content-Transfer-Encoding: 7bit
Message-Id: <58FFF1A3-DC37-4D9F-ABF0-3C5DA519BFFB@gmail.com>
References: <20221110151702.1478763-1-peterx@redhat.com>
 <20221110151702.1478763-3-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2022, at 7:17 AM, Peter Xu <peterx@redhat.com> wrote:

> +#ifdef CONFIG_DEBUG_VM
> +	/*
> +	 * Having write bit for wr-protect-marked present ptes is fatal,
> +	 * because it means the uffd-wp bit will be ignored and write will
> +	 * just go through.
> +	 *
> +	 * Use any chance of pgtable walking to verify this (e.g., when
> +	 * page swapped out or being migrated for all purposes). It means
> +	 * something is already wrong.  Tell the admin even before the
> +	 * process crashes. We also nail it with wrong pgtable setup.
> +	 */
> +	WARN_ON_ONCE(wp && pte_write(pte));

How about VM_WARN_ON_ONCE() and no ifdef?
