Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC62A6B9DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCNSKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCNSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:10:12 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA1CDED;
        Tue, 14 Mar 2023 11:09:58 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id s17so9421597pgv.4;
        Tue, 14 Mar 2023 11:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678817398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeGGg20zttuAcpRVo7sYITEgwV7sLq6I+dideNQqn3s=;
        b=LmPnM30p1kn2dSlZbBhLv8ntQ3hOh3VouEVLume6lswMkAZPz9cwqMFZwjZ7I4uDHn
         Gs0SpqITlKYwZsZd4imFycL2JeGohU6xzZeJCBzMgpEEnjnQ3RDU35nhNi8v88KMyu7g
         GZZgueB/KcWvOvMxtnGt2IEginOCLhrPGNEjxqwXBEGp3Dd+a3eeyZQwRDwyzW3YC2n0
         1p+PrWRMC13WWo0pAckiBiQPbBwl6Zry17zKSDB6dNYgg6NXmtcxlnI4FPdFIxLQszk1
         TqkgfQhPeSWCm9Doe76SUEcemXQZz9WYnBaW1U+5S1ZG2pY0Jf5DMit+ILx+fuio5JZt
         MADQ==
X-Gm-Message-State: AO0yUKWA3PaxTRU6ZUFJgntbp6ME03IRZz9HeIe31Gma+h8Bin2zj9q5
        mWRoUkmj06JHxk04O4f4IZdHUi4lLIA=
X-Google-Smtp-Source: AK7set8XCbSghnShchFszXHMoMq6WB5lGqe5smq6zqbYniRYY49l8NtzU0SSm8Jnndyntd7ZXt8zrA==
X-Received: by 2002:a62:6242:0:b0:5a9:c535:dba3 with SMTP id w63-20020a626242000000b005a9c535dba3mr28478754pfb.25.1678817398175;
        Tue, 14 Mar 2023 11:09:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9cdb:df66:226e:e52a? ([2620:15c:211:201:9cdb:df66:226e:e52a])
        by smtp.gmail.com with ESMTPSA id o6-20020a63f146000000b0050376cedb3asm1871662pgk.24.2023.03.14.11.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:09:57 -0700 (PDT)
Message-ID: <bde102c7-ab4f-a301-072f-8d6b7acde8a8@acm.org>
Date:   Tue, 14 Mar 2023 11:09:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] scsi: ufs: core: print trs for pending requests in MCQ
 mode
Content-Language: en-US
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1678792597-3232-1-git-send-email-quic_ziqichen@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1678792597-3232-1-git-send-email-quic_ziqichen@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 04:16, Ziqi Chen wrote:
> +static bool ufshcd_print_tr_iter(struct request *req, void *priv)
> +{
> +	struct scsi_device *sdev = req->q->queuedata;
> +	struct Scsi_Host *shost = sdev->host;
> +	struct ufs_hba *hba = shost_priv(shost);
> +
> +	if (!IS_ERR_OR_NULL(hba))
> +		ufshcd_print_tr(hba, req->tag, *(bool *)priv);

I think that the "if (!IS_ERR_OR_NULL(hba))" code can be removed safely. 
Otherwise this patch looks good to me.

Thanks,

Bart.
