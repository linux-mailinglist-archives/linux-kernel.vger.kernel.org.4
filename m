Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4C6BE7EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCQLVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCQLVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:21:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A8BF76E;
        Fri, 17 Mar 2023 04:20:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so4944397pll.8;
        Fri, 17 Mar 2023 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679052045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MwLiXEkSoODfLPV/T7b8EOfk9wVIiqqUoC/gH53lWZU=;
        b=Ttm6IQgPtKVqW35fvUeY6VXzeem1vkYZOaz7vrKbqQj84Ey4plajxvY5qeVS5aAce6
         Xkwcd0olSVfA/Pt70m1P4G+S5TwoKQ6+En8w3Y9Zhaa534QbBM3pGw8FoxdHQYCpzPEm
         vDXQlV0DA2NaGBjJhZz2svDF7liaMLdMlcxGLHBo4mcBGWLVug4R8MBTr0IqaK3zd8wM
         /UIyPPMOjC1Kbgst4AaM+SJvN3kd9EKEh1VLPosb4D8m8bBzlbU4xfabzadoAygf9A8j
         I8oxYJJT3O4GiOf+6Y5mAYH/yqbI46z+dKEdO4LS4O6A8QL/Huv9sMoxrmSm7x8crldR
         vYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwLiXEkSoODfLPV/T7b8EOfk9wVIiqqUoC/gH53lWZU=;
        b=KEXosVDyFbGnJ8fOyLA5Pmw40v88U7xQShUIZtWrcxSPVzm0hvjLabEm/thHF0aR7d
         yij+8XXUqHoy6G59FgEFcEgGXvkM39lfRxvWsZ4OBYiZzxecBUCoHXQbz0/2oxJtrlvg
         DXqGDlcP7h1G2rYhds3JnOg7We1HXVr4qFzIoWqNW2N2v/r0v8kTxA5zyQBClNtCnQ1/
         osVp/fQcizPtE7yNjN6YnSQSmlNhBTAfIWXVelxhVM9siiq3znlg6x7ofn3gggSesXYF
         ts4ybbg0k9IYbKr7jU1wkUhQ+5WWBdDwOR1A2Vmo2ZNfFZdKlwM74hsLR33brJXONyf2
         IRag==
X-Gm-Message-State: AO0yUKVPWEVNBM+q+/Ezfx8H4/4ceE+cCDqKoscZ8IMvIhSCpl7EfhIY
        UXDU2Bcg8jFc3ShEkPv6iQE=
X-Google-Smtp-Source: AK7set/62xLpYpXgwN2rSkGaoIOTq1VB0W8uBipmcDV+jPGswnD5z5uLk5Q3AY0HOm7fAjS0AE5Faw==
X-Received: by 2002:a17:902:d2c7:b0:19a:a520:b203 with SMTP id n7-20020a170902d2c700b0019aa520b203mr8979837plc.25.1679052045382;
        Fri, 17 Mar 2023 04:20:45 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b0019aa8149cb9sm1353820plb.79.2023.03.17.04.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:20:44 -0700 (PDT)
Date:   Fri, 17 Mar 2023 04:20:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/4] Input: bcm_iproc_tsc: drop of_match_ptr for ID table
Message-ID: <ZBRNCbrpzfy35mdO@google.com>
References: <20230312131514.351603-1-krzysztof.kozlowski@linaro.org>
 <20230312131514.351603-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312131514.351603-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 02:15:14PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry
