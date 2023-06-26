Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB273DF27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFZM22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjFZM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F78530EC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687782345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDHI+2QYFaocdNjg/agTcKpYLb3vBgPdGHQo8p/fVPI=;
        b=YeX0/mqN/Vdim4pahGW8pwa7zHG2qgLbVn4T5v18xwGC43XLRnhJH/nAEN8b9WrLAfNlhy
        9M1xgCdv4OBbijkeS/kRxAZtcSqe5wjp//7ny6WIbEzWdgn39Ep3gwcm6E73Nn2lL7/ASi
        7SFMUguFrLMOrgoCZmt2SAUuSex+P6w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-IfVzUUmpPvScdOPPyHm_DQ-1; Mon, 26 Jun 2023 08:25:33 -0400
X-MC-Unique: IfVzUUmpPvScdOPPyHm_DQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E69078A7F72;
        Mon, 26 Jun 2023 12:25:29 +0000 (UTC)
Received: from [10.45.226.134] (unknown [10.45.226.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65629200C0F2;
        Mon, 26 Jun 2023 12:25:28 +0000 (UTC)
Message-ID: <2096ab6c-7a14-85bb-22d6-3189507c4783@redhat.com>
Date:   Mon, 26 Jun 2023 14:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [dm-devel] [Question] Can DATA_DEV_BLOCK_SIZE_MIN_SECTORS be set
 to a smaller value
To:     Li Lingfeng <lilingfeng3@huawei.com>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <faeb60a9-8bde-d31d-acf5-a2bcda6cad72@huawei.com>
Content-Language: en-US
From:   Zdenek Kabelac <zkabelac@redhat.com>
In-Reply-To: <faeb60a9-8bde-d31d-acf5-a2bcda6cad72@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 26. 06. 23 v 14:19 Li Lingfeng napsal(a):
> Hello:
>
> Recently, I found that the used space of the thin-pool will keep rising if I 
> use dm-thin as follow:
>
> // create dm-thin
> dmsetup create linear_1 --table "0 2097152 linear /dev/sdc 0"
> dmsetup create linear_2 --table "0 16777216  linear /dev/sdc 2097153"
> dd if=/dev/zero of=/dev/mapper/linear_1 bs=4096 count=1
> dmsetup create pool --table "0 16777216 thin-pool /dev/mapper/linear_1 
> /dev/mapper/linear_2 128 0 1 skip_block_zeroing"
> dmsetup message /dev/mapper/pool 0 "create_thin 0"
> dmsetup create thin --table "0 14680064 thin /dev/mapper/pool 0"
>
> // mkfs and mount with discard
> mkfs.ext4 /dev/mapper/thin
> mount /dev/mapper/thin /mnt/test -o discard
> cd /mnt/test
>
> // create a file(17KB)
> dd if=/dev/random of=testfile bs=1k count=17 oflag=direct
> sync
>
> // truncate the file and write it for many times
> dd if=/dev/random of=testfile bs=1k count=17 oflag=direct
> sync
> ...
>
> Ext4 will issue discard IO to dm-thin when truncating file. However, 
> DATA_DEV_BLOCK_SIZE_MIN_SECTORS is set as 64KB which means the discard 
> covers less than a block when I truncating a 17KB file. As the result of it, 
> discard bio will end in process_discard_bio(), and more and more blocks will 
> leak.
>
> I'm curious about the reason behind setting DATA_DEV_BLOCK_SIZE_MIN_SECTORS 
> to 64KB. Is there any specific consideration for this? Would it be possible 
> to set this minimum limit to a smaller value, such as 4KB? 


Hi


The minimal chunksize for thin-pool was selected to  64K - smaller value would 
cause major expansion in the used 'metadata' size and further slowdown of 
metadata manipulation - so the 64K was set as minimal size.

Regards


Zdenek


