Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7EC699B83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBPRqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBPRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:46:35 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EFB4C3F8;
        Thu, 16 Feb 2023 09:46:35 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id b5so2819438plz.5;
        Thu, 16 Feb 2023 09:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inCt4UfQhzrVjZJORWD7A+ueESnX9lWn7iD06uQFXoM=;
        b=IE+EoZMmzfDVugt0d4diovC0wMM0fMfSct9N5G8B+qNbw2vxxtUhmWRybd1I8mT08d
         RvNg6CO2YfCzmqlPRu5QKHv0cQdp3D7fgtOwVv1TJX+QwsBXREQvYOJ99JHgPTXFRJh1
         SCQm5nYFy8OvEE2Glfh8NM2bFsxejO/K9vurZ0DcE/QY5K3QG21ghkoUKMN96IlWg/j5
         JnI83+CCQaqQtdUEunvisCovnanB5Vk4RT0QRLgT3tzvtLUP4iCtySmB4qYWlzwB7jMa
         TCqKrHFr+eJlbKzuzX2ZhhRL7WWVYJw/7WR369y/GEklLJW+rnMGX6tsu58A8ciCY/J4
         WKmg==
X-Gm-Message-State: AO0yUKWCmzLyztsfisIoUSRQDYSVwoPK4V3EJHL5amdpr7GEko8cf0qg
        SoecVJsbtbDvDhiI0ZWWOxc=
X-Google-Smtp-Source: AK7set8o00RWThdYLu0u33RJUiEVqiKbQpyOVtOl5d15NkjxmqwolNpHng2o2sZrhqoSsuSnDehZGw==
X-Received: by 2002:a05:6a21:6d88:b0:c7:20d8:dc1e with SMTP id wl8-20020a056a216d8800b000c720d8dc1emr3359795pzb.27.1676569594357;
        Thu, 16 Feb 2023 09:46:34 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:3a83:c047:6e5d:a776? ([2620:15c:211:201:3a83:c047:6e5d:a776])
        by smtp.gmail.com with ESMTPSA id d7-20020a656207000000b004fadb547d0csm1434401pgv.61.2023.02.16.09.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 09:46:33 -0800 (PST)
Message-ID: <0799ff2a-4775-46f0-38b9-ef28146fd6e1@acm.org>
Date:   Thu, 16 Feb 2023 09:46:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] ufs: mcq: fix incorrectly set queue depth
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, mani@kernel.org, beanhuo@micron.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <8840cea4a57b46dabce18acc39afc50ab826330f.1676567593.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8840cea4a57b46dabce18acc39afc50ab826330f.1676567593.git.quic_asutoshd@quicinc.com>
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

On 2/16/23 09:13, Asutosh Das wrote:
> ufshcd_config_mcq() may change the can_queue value.
> The current code invokes scsi_add_host() before ufshcd_config_mcq().
> So the tags are limited to the old can_queue value.
> 
> Fix this by invoking scsi_add_host() after ufshcd_config_mcq().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
