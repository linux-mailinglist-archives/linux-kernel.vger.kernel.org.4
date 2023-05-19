Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF57E70A309
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjESW7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESW73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:59:29 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD8299;
        Fri, 19 May 2023 15:59:28 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-24e16918323so2752682a91.2;
        Fri, 19 May 2023 15:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684537168; x=1687129168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sc+4sKuAVnCsRRFZyDycPPE7ku7z68s6fzQGZc0XWWI=;
        b=dtASnA/skP2Is0vSg5068h2X9zXaWHa7YmOzSohJmJ0yivtBKvTcjXPmr/C5Gv5F1V
         5pNuMhaNudH2adHL65K+oIamYFAKrJ4vhwnnivTkhJppAasJ+Nt+2RrbB071vuB+EeqY
         H3/zoiUixTMOBWN0/0IIVM6cqSur3k1IpzGkEicyKiXB/uxMa+73IPnu5xGmECiqGXxk
         K0aQ7JFPCEmXnNCpkxxb8PDvlTRstwANtYLwnO/cd82s9FEp+woRjQfM/unwpPYI0ZAg
         T4mAeqSKr0xcPnTIk4rOO4r4FnmkKXKha7PJo5isZa/TaMuvkNJUVsotamrCyUUc01tU
         jzLw==
X-Gm-Message-State: AC+VfDzJr7BF3HktSzgRSiEsCymNOD0GpTj3lheVSAzgupUUi89gteUr
        HscyraIvzQVEE+bOawdMMQsUZp1Zx6o=
X-Google-Smtp-Source: ACHHUZ44anxKWqZIZ9BTOAtlGNmmSVZ94Ky5mZtjdxCWyy6amU0na459B1gSNWf5wzSMK1O2JdnUMQ==
X-Received: by 2002:a17:90a:d188:b0:253:4212:9157 with SMTP id fu8-20020a17090ad18800b0025342129157mr3788026pjb.28.1684537167971;
        Fri, 19 May 2023 15:59:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id ch9-20020a17090af40900b0024df7d7c35esm131760pjb.43.2023.05.19.15.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 15:59:27 -0700 (PDT)
Message-ID: <772624e4-c463-4661-f433-6d60a489f023@acm.org>
Date:   Fri, 19 May 2023 15:59:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 6/7] ufs: mcq: Use ufshcd_mcq_poll_cqe_lock() in mcq
 mode
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alice Chao <alice.chao@mediatek.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>
References: <cover.1683872601.git.quic_nguyenb@quicinc.com>
 <15f2844264a3308347d3986f72e6078bcaca5b55.1683872601.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <15f2844264a3308347d3986f72e6078bcaca5b55.1683872601.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 23:28, Bao D. Nguyen wrote:
> In preparation for adding mcq error handler support, update the mcq
> code to use the ufshcd_mcq_poll_cqe_lock() in interrupt context
> instead of using ufshcd_mcq_poll_cqe_nolock(). This is to keep
> synchronization between mcq interrupt and error handler contexts
> because both need to access the mcq hardware in separate contexts.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


