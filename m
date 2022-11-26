Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B2D639282
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiKZALc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZALa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:11:30 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26113D910;
        Fri, 25 Nov 2022 16:11:29 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id 130so5356083pfu.8;
        Fri, 25 Nov 2022 16:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLJS0ozjYPHcBVcXrqu9nXfG4jqxc0v1MG8z2nceRi4=;
        b=Jf9BrQQxYg2UgwzNL8I3dCi5404G5H5pQFKAZAi+8/2pKBxez7AvEmtpzTOp0Oag9w
         i6yYWJKbYNqXF86j+tEgXoUYeg1pFs9Mfo1dyVkC5ecNOtDyKSp6jCGJKkVbYUqn4iZ/
         fOftb7u/jdouU/SJnROMAz/qMOzuVX6OeN4uQbVJPDr/cYh65wArPUyWSmrZ6+aWo7uk
         0eXMTFIAD8ckv62fTlb1ebQqQYrTxUqUrr3Srt2cQXDt+5VvTNjbZ8NBVb+85zo+K2AF
         aon+x3bH6BfXoBXBlm+NHRfUFflZuJjnDYwkoR+HTl/vJtruodiOXmIyAewFozwlCVY0
         5+2Q==
X-Gm-Message-State: ANoB5pn3Dcu65xAgogTWGYfDbjp6JO/z+6uqEg1FYysBXGhQCrwIHTxx
        8NSepYcIzbP9/yKaf9DhzAU=
X-Google-Smtp-Source: AA0mqf5Y874+p1CylOIaXkTfyH87v0jyxlWWC7FeoyhPbYZx88G4UvnHgcVSZQtR2NAaSIYWmx2jqg==
X-Received: by 2002:a05:6a00:18a9:b0:572:6da6:218e with SMTP id x41-20020a056a0018a900b005726da6218emr21577626pfh.1.1669421489243;
        Fri, 25 Nov 2022 16:11:29 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79568000000b005633a06ad67sm3623164pfq.64.2022.11.25.16.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 16:11:28 -0800 (PST)
Message-ID: <3dbfae56-918f-d850-11b4-5c98e3baae05@acm.org>
Date:   Fri, 25 Nov 2022 16:11:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 rcu 12/16] scsi/scsi_error: Use call_rcu_flush()
 instead of call_rcu()
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
 <20221122010421.3799681-12-paulmck@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221122010421.3799681-12-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 17:04, Paul E. McKenney wrote:
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 6995c89792300..634672e67c81f 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
>   	 * Ensure that all tasks observe the host state change before the
>   	 * host_failed change.
>   	 */
> -	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
> +	call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
