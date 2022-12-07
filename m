Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9AD646572
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLGXwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGXwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:52:08 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729B5C77D;
        Wed,  7 Dec 2022 15:52:08 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id a14so14827088pfa.1;
        Wed, 07 Dec 2022 15:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YZWA9EOi6vfbF2zsZ3N63z54cl4EigEwPPACJawtwg=;
        b=o/GpUfolOnbSeIKoSB6jTrPKMtasxaru9P6gn13hQXzPL67ciR3DKLlBcgI2FqBz1m
         XqSSicqz5/PWN1Fc+/ErPpeKUzFGaejBb9VDsRwAqQaOZLDuTOpjjc/InogpjFQW1Yea
         UngtAxVZaSbJ0r7r+TBjpuMlM9VWlJ7OzcG0asUszm6MZm53zPB9E6ldHx9OstT5ISE4
         D5MI1hiY2n5DF29zYLgUl97tulelcduBgSKXNl5TVPsyGL7MDQGGdgOJahd4R5Gj9LXP
         W9rf/3wF7hZyIkGl/ta+6mFh9panl/5DuyapgF/qC7zXdG3Xt+R73QuX5yRWJs0RXrai
         CArA==
X-Gm-Message-State: ANoB5pmSVGyy89CDy0V96RMgeCyv2aaf7s9dwH8tsKBu1pGA03JymTIf
        3rGw7y/v1BCLLVKCmNmoJiI=
X-Google-Smtp-Source: AA0mqf6wA5litM2o86mLTg7wFk7QJgknFWhEDLLFOthH+dhEAoGPcWzE7Rq/HEesdRRo3vYYmt/r2Q==
X-Received: by 2002:a63:60a:0:b0:478:80ac:566c with SMTP id 10-20020a63060a000000b0047880ac566cmr25845799pgg.320.1670457127497;
        Wed, 07 Dec 2022 15:52:07 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y67-20020a626446000000b005769436a23dsm8672586pfb.218.2022.12.07.15.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 15:52:06 -0800 (PST)
Message-ID: <b773928a-ef22-94f8-4bb9-f1aa013897c7@acm.org>
Date:   Wed, 7 Dec 2022 15:52:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length
 function
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1669550910-9672-5-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1669550910-9672-5-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 04:08, Arthur Simchaev wrote:
> There shouldn't be any restriction of the descriptor size
> (not the descriptor id for that matter) up to QUERY_DESC_MAX_SIZE.
> According to the spec, the caller can use any descriptor size,
> and it is up to the device to return the actual size.
> Therefore there shouldn't be any sizes hardcoded in the kernel,
> nor any need to cache it, hence ufshcd_map_desc_id_to_length function is redundant.
> always read the descriptors with QUERY_DESC_MAX_SIZE size.

This patch looks good to me but I expect that it will change if
my comment on patch 1/4 is addressed?

Thanks,

Bart.

