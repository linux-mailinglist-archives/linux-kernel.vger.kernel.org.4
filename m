Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260D365AF1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjABJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjABJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:58:46 -0500
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5F8DCB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:58:45 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 7966941C5B;
        Mon,  2 Jan 2023 04:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1672653524;
        bh=mlXog09AD8tM0bQkT/5+11IIdnU/V0C6NIq/OIo3ZEo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=vQPvKDGx+dsUeqmwAS+yOXVPKMcvM7wStjooOWRzEzrg/UB+mX8h56lFKyTsNPVCX
         JwvhpibEdb16uEneUnBdkadywuPo40/DkqR7ekLOqxAsUCXfYbngxTrbBwoowg7VHh
         CempMb+YVloI7Z+xzB4NUBz4/7/pQUGlsEkCWTDM+pW59CTWoG8rWY0ZbyHXpzGUJW
         2C4mN0CtZj3O8l1qbT73cZS7PYv3jM0aNMq7fqZYjDcSVW/g0wEOapsghFCduvFDsF
         ZCnnRMPt6nOaxtU1F9p92FX69Yn8mHwrUoX1qWAWNRs+vm6x1slsbYiy9CEKzMSkcy
         WQc6D4TaKsv1Q==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 2 Jan
 2023 10:58:40 +0100
Message-ID: <974ffb8c-8623-d249-f69f-ac5cfd498950@veeam.com>
Date:   Mon, 2 Jan 2023 10:58:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 18/21] block, blksnap: snapshot
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
CC:     <axboe@kernel.dk>, <corbet@lwn.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20230101110542.3395-1-hdanton@sina.com>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <20230101110542.3395-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx02.amust.local (172.18.0.172) To prgmbx01.amust.local
 (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031555657167
X-Veeam-MMEX: True
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/1/23 12:05, Hillf Danton wrote:
> Subject:
> Re: [PATCH v2 18/21] block, blksnap: snapshot
> From:
> Hillf Danton <hdanton@sina.com>
> Date:
> 1/1/23, 12:05
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>
> CC:
> axboe@kernel.dk, corbet@lwn.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org
> 
> 
> On 9 Dec 2022 15:23:28 +0100 Sergei Shtepa <sergei.shtepa@veeam.com>
>> +int snapshot_create(struct blk_snap_dev *dev_id_array, unsigned int count,
>> +		    uuid_t *id)
>> +{
>> +	struct snapshot *snapshot = NULL;
>> +	int ret;
>> +	unsigned int inx;
>> +
>> +	pr_info("Create snapshot for devices:\n");
>> +	for (inx = 0; inx < count; ++inx)
>> +		pr_info("\t%u:%u\n", dev_id_array[inx].mj,
>> +			dev_id_array[inx].mn);
>> +
>> +	ret = check_same_devices(dev_id_array, count);
>> +	if (ret)
>> +		return ret;
>> +
>> +	snapshot = snapshot_new(count);
>> +	if (IS_ERR(snapshot)) {
>> +		pr_err("Unable to create snapshot: failed to allocate snapshot structure\n");
>> +		return PTR_ERR(snapshot);
>> +	}
>> +
>> +	ret = -ENODEV;
>> +	for (inx = 0; inx < count; ++inx) {
>> +		dev_t dev_id =
>> +			MKDEV(dev_id_array[inx].mj, dev_id_array[inx].mn);
>> +		struct tracker *tracker;
>> +
>> +		tracker = tracker_create_or_get(dev_id);
>> +		if (IS_ERR(tracker)) {
>> +			pr_err("Unable to create snapshot\n");
>> +			pr_err("Failed to add device [%u:%u] to snapshot tracking\n",
>> +			       MAJOR(dev_id), MINOR(dev_id));
>> +			ret = PTR_ERR(tracker);
>> +			goto fail;
>> +		}
>> +
>> +		snapshot->tracker_array[inx] = tracker;
>> +		snapshot->count++;
>> +	}
>> +
>> +	down_write(&snapshots_lock);
>> +	list_add_tail(&snapshots, &snapshot->link);
>> +	up_write(&snapshots_lock);
> Given list_for_each_entry below, typo wrt &snapshots found in the fresh 2023?
> 

Thanks.
It seems I just swapped the parameters by mistake.
It should be better:
```
	down_write(&snapshots_lock);
	list_add_tail(&snapshot->link, &snapshots);
	up_write(&snapshots_lock);
```

>> +
>> +	uuid_copy(id, &snapshot->id);
>> +	pr_info("Snapshot %pUb was created\n", &snapshot->id);
>> +	return 0;
>> +fail:
>> +	pr_err("Snapshot cannot be created\n");
>> +
>> +	snapshot_put(snapshot);
>> +	return ret;
>> +}
>> +
>> +static struct snapshot *snapshot_get_by_id(uuid_t *id)
>> +{
>> +	struct snapshot *snapshot = NULL;
>> +	struct snapshot *s;
>> +
>> +	down_read(&snapshots_lock);
>> +	if (list_empty(&snapshots))
>> +		goto out;
>> +
>> +	list_for_each_entry(s, &snapshots, link) {
>> +		if (uuid_equal(&s->id, id)) {
>> +			snapshot = s;
>> +			snapshot_get(snapshot);
>> +			break;
>> +		}
>> +	}
>> +out:
>> +	up_read(&snapshots_lock);
>> +	return snapshot;
>> +}
