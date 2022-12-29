Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFB658B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiL2KCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiL2J7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:59:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C915F98
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:58:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso12858206wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMF1V+bX5VSu/qYwgCDVAw9SWhqjhgCVAzGi+L4Jh38=;
        b=VGKx215Qw+8PT9HN2XTTThZL6rhtlu7Qc3K1mPu8pI/L0q6dz9BioGygVGFMZACMG8
         RvDZf48kvrQzAzRIGCXzIFbYVKTv8VyFgPx4Yha6h6AbG2TTtsRVMCBDk0fut9ocb9Uh
         pgPeqA5EAUVmJ7PfNB0+DZ8YgefRCHq2NR590AI+4tQQmaiodN3HSR7JIud1MKKnLC3V
         tbsqDxljDVHqhTHosNgQB+d95JMBqyULR0bdsaI9UOh5HDgAlCXVuIOa/DkDQtfKNtbA
         3NxMOKQ4Ag7ZXpL00u2MEZtGyg25UuJXu9msRAn39QJPR+vw071k6T/0C0R9XklUblbd
         cApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMF1V+bX5VSu/qYwgCDVAw9SWhqjhgCVAzGi+L4Jh38=;
        b=TawT2kpo5BoS4s9vsv6Gad1pL5OEm6ZPRsTviNrglTPOc1FKXrQyvqj1YWwINrUiYV
         tnDfJcvDs2WD9Sa2t0prQWAeYeF1WyNx6BLrBHMM2CcRL1OaoKCyyB4LpT9Sx5avgWvO
         EWJDAcVqnkf/leWlbH7EmgDkUMfLZCc6SAYCVM6u8tstmrHDPcaO5jjyJoXrFBdBtc73
         i7V0TZZ1bknnkdn5hVNNtg42J/rNs2m6ITVGedoEp6/YxaFvTiK8C1HIEb8riEcnqatc
         z3xJFoaL5HZEBdcpPIgSAfJfrbOuzbhObz0rMzG1CMw5sF1Qe8LPkdly9FMIDfNfl6Ex
         xeEw==
X-Gm-Message-State: AFqh2koOCaQo7v+oE8gy1Fl7YMDTJOqpi3kgdNRdK75bs3uQl8dxrE/b
        V5Jj2Sxqo4fjlppz4GGLf74=
X-Google-Smtp-Source: AMrXdXslKLwy/ZCij67buma4kdC4M4YgEpnRQ+RiyykM6XMUwCmMLZnvhiJ8DLqH2JjyAZtGEfMLrw==
X-Received: by 2002:a05:600c:3b2a:b0:3d9:7950:dc6d with SMTP id m42-20020a05600c3b2a00b003d97950dc6dmr9644668wms.40.1672307905834;
        Thu, 29 Dec 2022 01:58:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003c71358a42dsm37644500wms.18.2022.12.29.01.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:58:25 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:58:22 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     yang.yang29@zte.com.cn
Cc:     gustavoars@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] staging: ks7010: use strscpy() to instead of
 strncpy()
Message-ID: <Y61kvh511t57acYC@kadam>
References: <202212261903245548969@zte.com.cn>
 <Y61hpuMcp3NKbqL5@kadam>
 <Y61j1JRx0ZMeVjji@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y61j1JRx0ZMeVjji@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 12:54:28PM +0300, Dan Carpenter wrote:
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Heh.  My fingers are on autopilot.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

