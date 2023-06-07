Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCA72694C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjFGSzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjFGSzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:55:03 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB52696;
        Wed,  7 Jun 2023 11:54:38 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6513e7e5d44so4587281b3a.0;
        Wed, 07 Jun 2023 11:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686164078; x=1688756078;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGiAZafvbgMjci4riKVs2WjWWK2srfpG0HwElIpYDrY=;
        b=it5heMos1Q4KiOkiydvNQrwjPrygXP3Az6JTsfUottzqKBedfObZm00oiCSQ54kwow
         Q1rYwpGwAMIF5yxLU3X6lEYVrtob6jvFDZy9uy0llmvAh8APrL9oxXE9pZeKbipNsHEF
         qzpaw6NnE0d2OIvqUqqcd9/GAarjmXIi3VejQxbhFLjmHabzsk4lATGElddpQ7dLLS7C
         q3YTkhhTvyi4tOaCHdusrhAj4CwG79xhLHEk6+g2p8VNkNKi+uDiO1GjLTB3slGAKVph
         p1uktHThjaEN9xRrSajv53v6Zuofp6X560YdkOEQwhqwtpC3kb4HxJzjPQQMRatLN6pP
         YgHw==
X-Gm-Message-State: AC+VfDxuI9DcBiemy6lXNYYHWTUHfcX2CV9PA/nv+MVuI5XipGEuPdy8
        i3GP9JJf3cRDZMITp7yqwT0=
X-Google-Smtp-Source: ACHHUZ40F49rmtVj3sZ7rs0LK2+jqZIItHUEYYCjU+TBqC7bYhteKBYkfk6lV7p1TpNBU7BsyddtIA==
X-Received: by 2002:a05:6a20:841e:b0:10b:dca4:8a3b with SMTP id c30-20020a056a20841e00b0010bdca48a3bmr2205714pzd.31.1686164077642;
        Wed, 07 Jun 2023 11:54:37 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78813000000b006542b17a9f6sm7450519pfo.194.2023.06.07.11.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:54:37 -0700 (PDT)
Message-ID: <e165b0fd-983a-91dd-eb74-dd2465758390@acm.org>
Date:   Wed, 7 Jun 2023 11:54:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] ufs: make __ufshcd_send_uic_cmd not wrapped by
 host_lock
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
References: <cover.1685927620.git.kwmad.kim@samsung.com>
 <CGME20230605012506epcas2p2c487b751827e3a39c74fdbd88dbd1311@epcas2p2.samsung.com>
 <002dcd4e99b2e03dcd698493f1f1adbb0375bf5c.1685927620.git.kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <002dcd4e99b2e03dcd698493f1f1adbb0375bf5c.1685927620.git.kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/23 18:15, Kiwoong Kim wrote:
> __ufshcd_send_uic_cmd is wrapped uic_cmd_mutex and
> its related contexts are accessed within the period wrappted
> by uic_cmd_mutex. Thus, wrapping with host_lock is
> redundant.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
