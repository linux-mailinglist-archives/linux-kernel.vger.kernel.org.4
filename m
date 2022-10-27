Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB52A61054D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiJ0WCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiJ0WBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:01:52 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BC6A026D;
        Thu, 27 Oct 2022 15:01:51 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id i3so3061775pfc.11;
        Thu, 27 Oct 2022 15:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xuf2rYc4skGV/brVADA47UOE0bGVgDUQN7KLwp1HwW8=;
        b=7T4uVmhQp+b2sCm0RWNy1Hj3WdJXv0flFD94q7W+1M5Tu4pqfSqcDzXtIBiqGJCtQ3
         /Sr4U2Sy/c3Ju77DVPLCh8tHncmCgpglm8KlWUWQbfV0kOaTx4eqfA5JubVI7aGc5Az4
         rympNxY7GRIETFxzG6/YIRoEQPh1NV1Ylz6h6VuAZ3Nz/CdNRhMx6VSrxslnWcECEjwu
         xsW80CmOKMv9hNt3Y5bv1yXWIr9qLxjkUHHGfWrKZwnc67MTDTkhNVfiSkOj1BC5q3vC
         4bxbQ4NK1faQ0x8g2MMbmXv7Zy7uanjeg6ktSMbrDoAZdIdtDQVFPTICweZRiprQdI6R
         4XsQ==
X-Gm-Message-State: ACrzQf1df9x2fu+EL65r28aKyHTl41Y9p5zkDorUzogQ4RSAsTjaOMqA
        ho8nexxrCUcejbdeiCPGNJo=
X-Google-Smtp-Source: AMsMyM63yLidIP4PV9Xc0SANp2ydp+HPviTsYt2HnMrs+WOCV8sF4IDlYE+H12U1KYsKv+/Xo3fhZg==
X-Received: by 2002:a63:480e:0:b0:46e:b96c:4f89 with SMTP id v14-20020a63480e000000b0046eb96c4f89mr30330659pga.201.1666908110449;
        Thu, 27 Oct 2022 15:01:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bc2b:ff19:1b02:257b? ([2620:15c:211:201:bc2b:ff19:1b02:257b])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b00181e55d02dcsm1675471pla.139.2022.10.27.15.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 15:01:49 -0700 (PDT)
Message-ID: <8113c37b-9917-b5f2-87c8-cb76f59c69da@acm.org>
Date:   Thu, 27 Oct 2022 15:01:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 09/17] ufs: core: mcq: Configure operation and runtime
 interface
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <84a13c45fa8edc375b3342a5b9b35fc097208bab.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <84a13c45fa8edc375b3342a5b9b35fc097208bab.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> +/**
> + * ufshcd_mcq_config_mac - Set the #Max Activ Cmds.
> + * @hba - per adpater instance

adpater -> adapter

> + * @max_active_cmds - maximum # of active commands to the device at any time.
> + *
> + * The controller wouldn't send more than the max_active_cmds to the device at
> + * any time.
> + */

wouldn't -> won't

> +#define MCQ_CFG_n(r, i) \
> +	((r) + MCQ_QCFG_SIZE * (i))

No need to spread this macro over two lines.

Otherwise this patch looks good to me.

Bart.
