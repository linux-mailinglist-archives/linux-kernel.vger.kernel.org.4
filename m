Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1BE6C08E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCTCZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCTCZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:25:20 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D2A14495;
        Sun, 19 Mar 2023 19:25:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Ve9mrKl_1679279113;
Received: from 30.240.114.229(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Ve9mrKl_1679279113)
          by smtp.aliyun-inc.com;
          Mon, 20 Mar 2023 10:25:14 +0800
Message-ID: <91796ce2-2f63-4b07-3e44-dc2a2a98615e@linux.alibaba.com>
Date:   Mon, 20 Mar 2023 10:25:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
 <SJ1PR11MB60836145DD10108B1FE13A4FFCBD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB60836145DD10108B1FE13A4FFCBD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/18 AM5:24, Luck, Tony wrote:
> -	if (val != EINJ_STATUS_SUCCESS)
> +	if (val == EINJ_STATUS_FAIL)
>  		return -EBUSY;
> +	else if (val == EINJ_STATUS_INVAL)
> +		return -EINVAL;
> 
> The ACPI Specification is really vague here. Documented error codes are
> 
> 0 = Success (Linux #define EINJ_STATUS_SUCCESS)
> 1 = Unknown failure (Linux #define EINJ_STATUS_FAIL)
> 2 = Invalid Access (Linux #define EINJ_STATUS_INVAL)

Absolutely right.

> 
> I don't see how reporting -EBUSY for the "Unknown Failure" case is
> actually better.

Tony, did you misunderstand this patch?

The original code report -EBUSY for both "Unknown Failure" and
"Invalid Access" cases.

This patch intends to report -EINVAL for "Invalid Access" case
and keeps reporting -EBUSY for "Unknown Failure" case unchanged.
Although -EBUSY for "Unknown Failure" case is not a good choice.
Will -EIO for "Unknown failure" case be better?

By the way, do you think -EIO for time out case is suitable.

	for (;;) {
		rc = apei_exec_run(&ctx, ACPI_EINJ_CHECK_BUSY_STATUS);
		if (rc)
			return rc;
		val = apei_exec_ctx_get_output(&ctx);
		if (!(val & EINJ_OP_BUSY))
			break;
		if (einj_timedout(&timeout))
			return -EIO;

For example, the OSPM will may warn:

    Firmware does not respond in time.

And a message is printed on the console:
    echo: write error: Input/output error

Will -EBUSY or -ETIME for timeout be better?

> 
> -Tony

Thank you for comments.

Best Regards.
Shuai
