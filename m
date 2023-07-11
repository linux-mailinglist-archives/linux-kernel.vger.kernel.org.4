Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BBA74F105
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjGKODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjGKODt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3810EA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689084175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MN7azwrh4yAlA1aQm5F+hx59xHelDrZm48bMHSPycs=;
        b=UZ5Dm5s2017EMH6Z/U64rWgAN3r6gSK2URa/kf82XNNuxwXu5N3BymyRYvgxOeU8zZSonW
        Xo226cPp2JkgQ/rDxW8BCzwWVC/2UNlSjD2uE56fzaB90T7y9ezK7rnCPLdNqsSP+DTrKB
        UtJiAQ1mx1R2WBUc32snWt5P04ADkxM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-geqgk1t9Mw-9A18qOSjSVw-1; Tue, 11 Jul 2023 10:02:49 -0400
X-MC-Unique: geqgk1t9Mw-9A18qOSjSVw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7623a751435so526568085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689084168; x=1691676168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MN7azwrh4yAlA1aQm5F+hx59xHelDrZm48bMHSPycs=;
        b=EcRJ5kUsTKO3ERzjLqotVZ9gGINp6kOEKj4Z+WWqwzpwvufitwa3EVnrKxTFd5f1bl
         g6Git3SaO2tTMLKd4d0Gkf8j07pX7gq+FW/PTxfd/C1XQQCNIBNQyH5Wf3YsPQsqh5Bf
         oBFA61MzV4IiEChadFPbGpPaVqowFcPBSwfgguUJ8uKmETweQkCTpGJL6DjmwjGVvDXG
         rDDte33v9HJh6MiakB1qGO/r5ubNE4Y51cFm6O1HwIfBSYXg6CuS1uUvO4rV+fkQv2Fd
         MFshQ59QJ+1ot1B2hji67/tY6UdxXlQPHOa60HO4+OPWcTaDHdKyb2B56WD075XrvPg0
         4Biw==
X-Gm-Message-State: ABy/qLYBm0ArTa5y7/TkPNQH2RWUKHeVAhZrNrgHSJfJ0NiwB5izNdOg
        y8sj03NDAZ/S+06fhGaDN/yENEgb5ZyLHNi9fqJ3yNHQbtyrlhDgboe3EMDN4Jad88qyT46cZME
        lz5KXJcwITarQxlM61nQ38W5PMHf+I4g=
X-Received: by 2002:a05:620a:838a:b0:767:e0f7:1206 with SMTP id pb10-20020a05620a838a00b00767e0f71206mr1496959qkn.29.1689084168264;
        Tue, 11 Jul 2023 07:02:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGFizy6nYQpcqIQHmvaEG+fhrP1mN7OQS0BKarTGFl9M/FzbWetSLyFpaz/atc8YwCvMsbjNg==
X-Received: by 2002:a05:620a:838a:b0:767:e0f7:1206 with SMTP id pb10-20020a05620a838a00b00767e0f71206mr1496940qkn.29.1689084167946;
        Tue, 11 Jul 2023 07:02:47 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id e9-20020a05620a12c900b00767ccf42f3csm1012759qkl.66.2023.07.11.07.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:02:47 -0700 (PDT)
Message-ID: <1d03a695-d603-a4d5-b726-4b0ff6bc33f8@redhat.com>
Date:   Tue, 11 Jul 2023 16:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 1/4] fpga: add an initial KUnit suite for the FPGA
 Manager
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230630152507.30219-1-marpagan@redhat.com>
 <20230630152507.30219-2-marpagan@redhat.com>
 <ZKuMosEu242BrY0K@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZKuMosEu242BrY0K@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-07-10 06:44, Xu Yilun wrote:
> On 2023-06-30 at 17:25:04 +0200, Marco Pagani wrote:
>> The suite tests the basic behaviors of the FPGA Manager including
>> programming using a single contiguous buffer and a scatter gather table.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fpga-mgr-test.c | 311 +++++++++++++++++++++++++++++
>>  1 file changed, 311 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
>>
>> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
>> new file mode 100644
>> index 000000000000..6fd2e235f195
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fpga-mgr-test.c
>> @@ -0,0 +1,311 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit test for the FPGA Manager
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +

[...]

>> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
>> +{
>> +	struct mgr_stats *stats = mgr->priv;
>> +	size_t i;
>> +
>> +	/* Check the image */
>> +	stats->image_match = true;
>> +	for (i = 0; i < count; i++)
>> +		if (buf[i] != IMAGE_FILL)
>> +			stats->image_match = false;
>> +
>> +	stats->op_write_state = mgr->state;
>> +	stats->op_write_seq = stats->seq_num++;
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
>> +{
>> +	struct mgr_stats *stats = mgr->priv;
>> +	struct sg_mapping_iter miter;
>> +	char *img;
>> +	size_t i;
>> +
>> +	/*
>> +	 * Check the image, but first skip the header since write_sg will get
>> +	 * the whole image in sg_table.
>> +	 */
>> +	stats->image_match = true;
>> +	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
>> +
>> +	if (!sg_miter_skip(&miter, HEADER_SIZE))
>> +		stats->image_match = false;
> 
> If this fails, should we continue?

Would it be okay to set the image_match flag to false and then
return 0 if sg_miter_skip() fails?

I think returning an error code to the FPGA manager would not
be beneficial in this case since if an op fails, it is a failure
of the FPGA manager itself, not the low-level driver that tests
the FPGA manager.


> 
>> +
>> +	while (sg_miter_next(&miter)) {
>> +		img = miter.addr;
>> +		for (i = 0; i < miter.length; i++) {
>> +			if (img[i] != IMAGE_FILL)
>> +				stats->image_match = false;
>> +		}
>> +	}
>> +
>> +	sg_miter_stop(&miter);
>> +
>> +	stats->op_write_sg_state = mgr->state;
>> +	stats->op_write_sg_seq = stats->seq_num++;
>> +
>> +	return 0;
>> +}
> 

