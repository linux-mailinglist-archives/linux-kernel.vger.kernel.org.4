Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFBD73FEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjF0OtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjF0OtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:49:00 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF930E5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:46:47 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4009ea1597bso23129401cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1687877201; x=1690469201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sx2I2uTHzyFWwymbKmW6SHOFKTNzQ5cGIsjHspz4koA=;
        b=ZELrA/9I+gnOIdSusx5IIl2N9aNIvxXXeGGmk8e5HI3PYQ1IIgx7xZdjnuYlAy8mkp
         0G7ZnnXRnnSOI6ZfevieJaoYOJRHBhS3BrrtoiJHqpN0qrcisK87zGQBjlog80atBDv6
         rFBWHKIL+GOM4N0g/u1w7IUav2KTcFK8LsMzmgtaNt/HkfWbQSntk9q8DxTZGBWPsihv
         wDqDMc1RlpW7jkI8xGZlik+VEQ2O5hnfXlAGd8LUAQ845g57pvSQHSM3twpkzP+lMGhr
         /xWFBsXi3BysfsllnhectRxRvkdd989PH298AyLoNeX5Fr+rY5I7RMBVMrzzMlqDaO92
         Hg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687877201; x=1690469201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sx2I2uTHzyFWwymbKmW6SHOFKTNzQ5cGIsjHspz4koA=;
        b=V3GN0P5xjwVkh9rYY6v0erZTnQGwg3ZsET+JuQ3/ur62nBKZ6nNAVLBtoaWpcKEKsr
         TEQqahX5KdyQXIogUq4dSpSdhur5FVP6V2o58eIFSnfq9+++Qso1L7AsVxId+seEGGKb
         9YkjlSJnwjKUCVbHDzBkETwiiNRMaznKwYIOC0BV4/AJ5gsLnDDle2MD1EEIQHYFdzHb
         pdEKUur9WlsQQBe4g/RX8v2QiwsObnWoDxcpeEI5ECsXi440Dxb4RpLOxh5lasONBv1Y
         WyPBxg3gFu+7VaEkpqoLGRGs353NHVC1zXsvw20VIIdN7wf97KTSv5CaN9irwfbLtL//
         2hnQ==
X-Gm-Message-State: AC+VfDxTb7rsFXHYe3voYhvMpMdDxh+xrT9k7j4qs5Em9kWv8zJt7nDm
        OLBra3NUyAiO5uld4TQf1qxUqQ==
X-Google-Smtp-Source: ACHHUZ6hWYDxmlOuzkAWCv6V6pOmoUF7l8ZC7BNyWQw8rQRVSNz8/Su8DeUifEIa/1aCckgdpPiyng==
X-Received: by 2002:ac8:5f0a:0:b0:3f6:ac1b:47b3 with SMTP id x10-20020ac85f0a000000b003f6ac1b47b3mr36857835qta.34.1687877200763;
        Tue, 27 Jun 2023 07:46:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:3a96])
        by smtp.gmail.com with ESMTPSA id bt3-20020ac86903000000b003f9a79fe046sm2465029qtb.38.2023.06.27.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:46:40 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:46:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, surenb@google.com, minchan@kernel.org,
        quic_pkondeti@quicinc.com, quic_smanapra@quicinc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: madvise: fix uneven accounting of psi
Message-ID: <20230627144639.GA52561@cmpxchg.org>
References: <1687861992-8722-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687861992-8722-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charan,

thanks for fixing this. One comment:

On Tue, Jun 27, 2023 at 04:03:12PM +0530, Charan Teja Kalla wrote:
> @@ -413,6 +413,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  
>  		folio_clear_referenced(folio);
>  		folio_test_clear_young(folio);
> +		folio_set_workingset(folio);

Unless I'm missing something, this also includes inactive pages, which
is undesirable. Shouldn't this be:

		if (folio_test_active(folio))
			folio_set_workingset(folio);

> @@ -512,6 +513,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		 */
>  		folio_clear_referenced(folio);
>  		folio_test_clear_young(folio);
> +		folio_set_workingset(folio);

Here as well.
