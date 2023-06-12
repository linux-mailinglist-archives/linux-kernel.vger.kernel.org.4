Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51FF72C28C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbjFLLJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbjFLLJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:09:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A716A47
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:58:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30fc50d843aso333246f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686567483; x=1689159483;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdIRBmqETceRv4AXIkJcnCbFdaBYDslyf8hvML1Uo5o=;
        b=aTIIz1uzhIwDHYGznxgCwif3g/gpSmRsWRe3aQHDwzfG54//GJMJv8hNz4NAaMFxVV
         n0yqgzFld3JRgEs82PztAmYIapE/4rpdgiv4g1Oz57vzs/iWbeyGmlWNQ95ccMevBs4P
         B6PPWnKNrq0oIGCdl6H/OZqR1fSnnwlvXjoNABKD+f7Epz8Cc47QABJnFiJU1Nv+uJt1
         ZFZvqdfla9Lf/EWaBqDhyPMHKvnWwsM+NQw1/H9i3dm631W4CzekXfecCtR7rUuBHVYp
         /QRd2BFEspRoAaLe+XqgN6XXgxKfDnohAwq9xEWGaImyTFcXbAzr3VpdpdQrHXWy1BdD
         3Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686567483; x=1689159483;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdIRBmqETceRv4AXIkJcnCbFdaBYDslyf8hvML1Uo5o=;
        b=C2eU4uGelwVEgrxOtgSMqGNsjg/NrFCPu8mo0BFyzpntkq3JotWjj6G3nCMf5kF7Tn
         gO954Ne7K5s4jJCYZbUGFI14jdCIQs61j2UKAH81lkkUFKPvh85DhQcxTdI4DKpXOjgL
         NdFAs4mmKHu4eh3OwYMR3SiXMZIZOgjV+cfAf2bBgdNqQpjuF3lCfd0fazOH9hLvcWUk
         kH1GPNOfMyxGIS/RYdxkv5chaQnnSagznXlbnVE2rYe5/FbLoUgcKk2ghKwmPgmlaTml
         uZsLwLDhUhY9Yt3CzmpVuZ5b+9mzeZxVhRoPwnPKCrQcEjoKUMYQeGbNdExaPAyWmu3Y
         NW7A==
X-Gm-Message-State: AC+VfDxopQS9+GHK1Mp5OL5HmZbjDhcCTYRjBHH396j4ME8EW8eTeMxL
        tSaphla6lLf3L74Skr1GLQ3FHw==
X-Google-Smtp-Source: ACHHUZ5X3XNo0Qd1vpLxPAQAD5H7Owr80BMJaeu6uIlU+e0Y4zUKu443qPjFPAn8aLU4e2x6tGZBAg==
X-Received: by 2002:adf:cd12:0:b0:306:3352:5ba3 with SMTP id w18-20020adfcd12000000b0030633525ba3mr4312427wrm.25.1686567483031;
        Mon, 12 Jun 2023 03:58:03 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d5584000000b0030fc576633dsm1489449wrv.16.2023.06.12.03.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:58:02 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sukrut Bellary <sukrut.bellary@linux.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230602113602.1271695-1-sukrut.bellary@linux.com>
References: <20230602113602.1271695-1-sukrut.bellary@linux.com>
Subject: Re: [PATCH v2] misc: fastrpc: Fix double free of 'buf' in error
 path
Message-Id: <168656748193.162074.17313550564907901438.b4-ty@linaro.org>
Date:   Mon, 12 Jun 2023 11:58:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 02 Jun 2023 04:36:02 -0700, Sukrut Bellary wrote:
> smatch warning:
> drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'
> 
> In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
> fastrpc_req_munmap_impl() if unmap is successful.
> 
> But in the end, there is an unconditional call to fastrpc_buf_free().
> So the above case triggers the double free of fastrpc buf.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Fix double free of 'buf' in error path
      commit: 5b3006fffce89706a12741d7f657869ca2be1640

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

