Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0008A5F2426
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJBQsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJBQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:48:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F13BC65;
        Sun,  2 Oct 2022 09:48:50 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i17so5489571qkk.12;
        Sun, 02 Oct 2022 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Zq0igB25OgS0yzOrs53xrvSd8tEF6kV3kvafs6KNIIU=;
        b=VFUY7+y8fAQRbwHJbFIYddgErlbUYizbMkrdGTp5nlTd3xupd++BU6jH5/POS9gerR
         CQFd5LCXJvmZzJebyG/YKZz88nKInLovQafPapvLxmpwU14uFcswQXk6w5gwb2xAv8WZ
         lk1z1zLsNcwKnn2mAx6PLeZkq0iQWmZv28qpuxBsbH26zH9kj/3UA6SK6oE+PH2N4iFD
         BpQPEymCAXQq4tanIb40UdGW5OUf3Z3LTJbNJFzI15pBB3kmlYGTDXKWHKOkquicvOjx
         tXWF1yE3RTqOe2fVL8idnhTjH0jLd2PoBDsE3bxcGQqPaIGe3Jws8S8zBYcwsjLAEUF3
         U44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Zq0igB25OgS0yzOrs53xrvSd8tEF6kV3kvafs6KNIIU=;
        b=bRp7YwxLNHPdGuzSAGqFRf6QUPt8S4HxPom4t7ghAOCnW80mvzgub4ncC9SCgOe1SO
         lqjQn8CdTbuw6RaroAcslmdrv35UV1QmN52p8ryXtNhQnHIZg4eD1h0Th4vRKffZuHwp
         baj8nUqRH/xzT6S4C1iZhQL17a8CI3qDq7ck6srdp5he70zfWk/OktPz6AsTf1zYD9Zz
         yTdra2xG90VvA56794myNuSO/3yYq8NUlE/aSD0UCqU23jWb32wRX0n14L/KIZ39DRe2
         HlZfvJCCdsYI0UHNxDwKg1lzIWqAMhzzV6MVS6m32kQ8dQ+hSzZrjFIE9GfwGMYHaWPQ
         jLVA==
X-Gm-Message-State: ACrzQf2u1iDCBSNjJQPmarOwFPNrBgBAFjr14GsD3+/wj/J7BnUQ92ax
        exmMeXw+uS1bAckMyAMFEAo=
X-Google-Smtp-Source: AMsMyM79+I24oCTIgpZyNz3siNy8kKl8pU3kysYTaRtwEKQ8FxufbDQWAkjwLy69LfutF4ZHgCIFMg==
X-Received: by 2002:a05:620a:45a5:b0:6ce:7320:60d4 with SMTP id bp37-20020a05620a45a500b006ce732060d4mr11803205qkb.775.1664729329539;
        Sun, 02 Oct 2022 09:48:49 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id l5-20020ac80785000000b0035cf31005e2sm7187720qth.73.2022.10.02.09.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:48:49 -0700 (PDT)
Message-ID: <8f30bdb4-05b9-d85c-cf78-80f8589ffeb5@gmail.com>
Date:   Sun, 2 Oct 2022 09:48:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] scsi: lpfc: Fix memory leak in lpfc_create_port()
Content-Language: en-US
To:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        Hannes Reinecke <hare@suse.de>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220916035908.712799-1-rafaelmendsr@gmail.com>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220916035908.712799-1-rafaelmendsr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2022 8:59 PM, Rafael Mendonca wrote:
> Commit 5e633302ace1 ("scsi: lpfc: vmid: Add support for VMID in mailbox
> command") introduced allocations for the VMID resources in
> lpfc_create_port() after the call to scsi_host_alloc(). Upon failure on the
> VMID allocations, the new code would branch to the 'out' label, which
> returns NULL without unwinding anything, thus skipping the call to
> scsi_host_put().
> 
> Fix the problem by creating a separate label 'out_free_vmid' to unwind the
> VMID resources and make the 'out_put_shost' label call only
> scsi_host_put(), as was done before the introduction of allocations for
> VMID.
> 
> Fixes: 5e633302ace1 ("scsi: lpfc: vmid: Add support for VMID in mailbox command")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 

Looks good

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


