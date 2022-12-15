Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0064DA46
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLOLax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOLaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:30:46 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B76D2709;
        Thu, 15 Dec 2022 03:30:42 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h10so9591739ljk.11;
        Thu, 15 Dec 2022 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXn6HifCWq1JlSGrtQpUbdd1OwF62/y9hWZc/OllYLc=;
        b=dj29mqLu1uJstcU8Uy3IHbOamfmYEcdN2djPk4k8Yt/F9Rzxjp89Zj9LARcjy3hpKG
         tS3qRPZZMT3BGTzM3J8BBUWTtIu6580bI0j8VLYiz7LTOw6FTQZKuepwbfQJG7ljFi6N
         6Ig0GRl90v9aQbaBlx7deplBDGGK7BoPl5H4pob1FozREoN/F+/cbDXqM4JD9Y5Z3WQz
         Kf4I08KZJzJG/at3QwwuSLHi3krilsAfb9h8IWfr+VJKCbBNOKiRQcUuK2OUAntk366J
         cbp2tqG7xaJzrfFidEs7O4a58KlmlhtNcI/VXoJz2YEljA4naAcRdzIF7qJWQNlqwox7
         GuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXn6HifCWq1JlSGrtQpUbdd1OwF62/y9hWZc/OllYLc=;
        b=B496ror3mPVaeXn3l+yNbXSQ/wH0ZNb4oKNd5KmECFUbr9lERPzBDPGVdUXoS8pcy/
         /VgIx2RUqk/2TiAXO1agosqdVJKybTE9EY+AJyzCxfLpvZjVH61VRERqsZiZT/EKkOLs
         YQ1cIyz603jm1rYGKsVHng6mfqpdJPub4uvjiDpB10BujyxDLzmyhINewIL2ZGgY5wc1
         cqCzQsA9RxIBBnd8NmmCUPynwWSdUxSCQRvt5Y3cmJQgwnwTdEX4G+n3vofewx8kXzG/
         eSabHyPw07VAKrczeRe3PDm5WpFhBbqbWyrutQz+zrb8IBVniBYiw5yrzXGrj4TwgUnw
         /BUg==
X-Gm-Message-State: ANoB5pkWpNBacLX0wKMz+GwYDavjp6g4FGfPua/ox8OnVFns5xa0700z
        OfNWUPVAW5LMmoraP+bJQ3w0hUxNTnI=
X-Google-Smtp-Source: AA0mqf46ZmpcIX8pzYzb5pdj2oZ9LK33Y8vdo+OgQQ4WU/Pob4sB/x/6/GAkT37d1YKUyS1/ac0RGA==
X-Received: by 2002:a2e:9f49:0:b0:27a:1d04:6709 with SMTP id v9-20020a2e9f49000000b0027a1d046709mr7102029ljk.42.1671103840323;
        Thu, 15 Dec 2022 03:30:40 -0800 (PST)
Received: from [192.168.1.103] ([178.176.75.188])
        by smtp.gmail.com with ESMTPSA id i66-20020a2e2245000000b0027a099ad7efsm805217lji.35.2022.12.15.03.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 03:30:39 -0800 (PST)
Subject: Re: [PATCH v2] ata:libata-eh:Cleanup ata_scsi_cmd_error_handler
To:     Wenchao Hao <haowenchao@huawei.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     liuzhiqiang26@huawei.com, linfeilong@huawei.com
References: <20221215105747.1927412-1-haowenchao@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <f552f2ab-895a-14dd-d391-a7b1c9930c88@gmail.com>
Date:   Thu, 15 Dec 2022 14:30:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221215105747.1927412-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  The subject should really look like "ata: libata-eh: Cleanup
ata_scsi_cmd_error_handler()"...

On 12/15/22 1:57 PM, Wenchao Hao wrote:

> If ap->ops->error_handler is NULL, just return.
> 
> V2:
> - Check ap->ops->error_handler without taking the spin lock

   This normally belongs under ---...

> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/ata/libata-eh.c | 96 ++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 34303ce67c14..c445c272e77f 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
[...]
> @@ -584,62 +589,57 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  	 * timed out iff its associated qc is active and not failed.
>  	 */
>  	spin_lock_irqsave(ap->lock, flags);
> -	if (ap->ops->error_handler) {
> -		struct scsi_cmnd *scmd, *tmp;
> -		int nr_timedout = 0;
> -
> -		/* This must occur under the ap->lock as we don't want
> -		   a polled recovery to race the real interrupt handler
> -
> -		   The lost_interrupt handler checks for any completed but
> -		   non-notified command and completes much like an IRQ handler.
>  
> -		   We then fall into the error recovery code which will treat
> -		   this as if normal completion won the race */
> -
> -		if (ap->ops->lost_interrupt)
> -			ap->ops->lost_interrupt(ap);
> +	/* This must occur under the ap->lock as we don't want

   The multi-line comments should start with /* on its own line...

> +	 * a polled recovery to race the real interrupt handler
> +	 *
> +	 * The lost_interrupt handler checks for any completed but
> +	 * non-notified command and completes much like an IRQ handler.
> +	 *
> +	 * We then fall into the error recovery code which will treat
> +	 * this as if normal completion won the race
> +	 */
> +	if (ap->ops->lost_interrupt)
> +		ap->ops->lost_interrupt(ap);
>  
> -		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> -			struct ata_queued_cmd *qc;
> +	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
> +		struct ata_queued_cmd *qc;
>  
> -			ata_qc_for_each_raw(ap, qc, i) {
> -				if (qc->flags & ATA_QCFLAG_ACTIVE &&
> -				    qc->scsicmd == scmd)
> -					break;
> -			}
> +		ata_qc_for_each_raw(ap, qc, i) {
> +			if (qc->flags & ATA_QCFLAG_ACTIVE &&
> +			    qc->scsicmd == scmd)
> +				break;
> +		}
>  
> -			if (i < ATA_MAX_QUEUE) {
> -				/* the scmd has an associated qc */
> -				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
> -					/* which hasn't failed yet, timeout */
> -					qc->err_mask |= AC_ERR_TIMEOUT;
> -					qc->flags |= ATA_QCFLAG_FAILED;
> -					nr_timedout++;
> -				}
> -			} else {
> -				/* Normal completion occurred after
> -				 * SCSI timeout but before this point.
> -				 * Successfully complete it.
> -				 */
> -				scmd->retries = scmd->allowed;
> -				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
> +		if (i < ATA_MAX_QUEUE) {
> +			/* the scmd has an associated qc */
> +			if (!(qc->flags & ATA_QCFLAG_FAILED)) {
> +				/* which hasn't failed yet, timeout */
> +				qc->err_mask |= AC_ERR_TIMEOUT;
> +				qc->flags |= ATA_QCFLAG_FAILED;
> +				nr_timedout++;
>  			}
> +		} else {
> +			/* Normal completion occurred after

   Here as well...

> +			 * SCSI timeout but before this point.
> +			 * Successfully complete it.
> +			 */
> +			scmd->retries = scmd->allowed;
> +			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>  		}
> +	}
>  
> -		/* If we have timed out qcs.  They belong to EH from
> -		 * this point but the state of the controller is
> -		 * unknown.  Freeze the port to make sure the IRQ
> -		 * handler doesn't diddle with those qcs.  This must
> -		 * be done atomically w.r.t. setting QCFLAG_FAILED.
> -		 */
> -		if (nr_timedout)
> -			__ata_port_freeze(ap);
> -
> +	/* If we have timed out qcs.  They belong to EH from

   And here...

[...]

MBR, Sergey
