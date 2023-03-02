Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940706A7C67
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCBITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCBITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:19:38 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A910F3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677745174; x=1709281174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KKyEdtNDOhebKEQjj/Qmh1erCfjwM0PsZRUXNGv/4xM=;
  b=F2Qt4magEaGefouD+pfgrPS8ngWV2YdQp55RtdwvVIt2qsy5qF9HeqhB
   2wxncRHSupm+2BQkSwYrgCMOqhouVinc8+CIoimFlVc4MqWcqAb/hs3YC
   Cfrobu3aYhJztTDDGTVfwIQ50enQjM5Y4XM/IPL/PhVzwc1mLiZEUyhTQ
   ONogJJ0Xz/xMdrOaN/KcGRfYm1bOVJv4GrvY/nSQo8tnxhd9hvaqkHueQ
   m+p/Afi6wUuFkzvdC1EkpUENyITYcYGPVz813ukMff3Ir5IvTQWhwhpJq
   KcmagUf020u3CsmTapLo3x1VhsC5Le6G03jBMQH0teyc+k8Xx77GZTV/Y
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224390337"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 16:19:23 +0800
IronPort-SDR: pan+VCVTgmWCxRgjIpjj7OncvVKey13HMo0KmaL7yTJnwu4S6jLUiYEZtd6UkF10hGrwQ+vAej
 G0F9WiYCEYVeYVG6J470O9OyXHkxDIhMcchTrA6FHkOf9/316JPPDfBdaL4zwQgPCBDIGSz81J
 heJZlv3AUADFSUU7tO6iPCNrfDb53Jjw1nrXEgP6IEe2f3Uwh+oH11FeudBfZcOrV1BJMWIXbo
 OUKadQiny4Hz6nihWiu+gZ5P7NfyeHrUZJPAATF1RyWVUuA+WUXkCkBV21HqWu9alHYwid3c/l
 SGs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 23:30:28 -0800
IronPort-SDR: GfmfME/QGAxFTewS80NOHIE43EsY+xLvMU/x4de0lhPajT/XqRPqlT0fPPlgtEMy9OvgmjaqlH
 DMHDZ/DpC8g790y+PIu8ksf6XrazVcUtVIP2e9ljKRzMBmZ3kvl/AksiOsQwGiz/eBBz69jZ+z
 UATc5PWjVrKw9SN8vmPRoEbn1+ULUyG3+0VQrOpCJNCZjQv5ip45WzO1p3YVW8sduzB79DWVTu
 fC0BrstFTfP5Q7rHam5Jipda9LILDGMSd+Vl5K2Oa9hkvsCxD85vEyvx7ypdy/l0i5G6dXv10Q
 6Qo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:19:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PS3t35MNJz1Rwt8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:19:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677745163; x=1680337164; bh=KKyEdtNDOhebKEQjj/Qmh1erCfjwM0PsZRU
        XNGv/4xM=; b=mB50Sf+llKHkJMt2P6iQ54lvHazfPTk3E14GwdXQZ76Dt5TeIfy
        Xhgf3q8XToFWxnX+uuq3NQWieTZy3ayXjXTbVhmOVaq9VDdMJINmFuWJwxMKscu4
        380mtcNlv8B/6LQe/gdlkN8NVNCjkpjs7Q4h6gbfWnR+JXAAD97ngo8r95Os8LsF
        rWLti251f9BjnClZqh4N6I2MzGKE5FnDnpUPetdNgwkrCUfjeOvmXfcbSl/uEmID
        IpVFZP/A2mdwwOjH5xH5lwqLYrbGMeNBQFQqF2gDnQGVOxU5OXakJ/ijVq81bo7Y
        Hs6bPxEgMOOuyA8XcAMvl+SyrJHyOWMfqVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7jLG0j7JY-DW for <linux-kernel@vger.kernel.org>;
        Thu,  2 Mar 2023 00:19:23 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PS3t15fGpz1RvLy;
        Thu,  2 Mar 2023 00:19:21 -0800 (PST)
Message-ID: <0d0e5c63-a155-d2ad-1829-c016c61acad6@opensource.wdc.com>
Date:   Thu, 2 Mar 2023 17:19:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
References: <20230224200502.391570-1-nmi@metaspace.dk> <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <87o7pblhi1.fsf@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 16:31, Andreas Hindborg wrote:
>>> +struct ublk_param_zoned {
>>> +	__u64	max_open_zones;
>>> +	__u64	max_active_zones;
>>> +	__u64	max_append_size;
>>> +};
>>
>> Is the above zoned parameter enough for future extension?
>> Does ZNS need extra parameter? Or some zoned new(important) features?
> 
> @Damien, @Hans, @Matias, what do you think?

Yes, add some reserved fields. The struct is 24 B for now, you can make it 32 B.
But it is a little odd: why 64 bits for max open/active zones and max append ?
bio len is 32 bits and number of zones also 32 bits. You do not need 64 bits for
all these fields. Also, no zone model reported with this ? What about write
granularity (for SMR HDDs) too ?

So something like:

struct ublk_param_zoned {
	__u32	model;
	__u32	write_granularity;
	__u32	max_open_zones;
	__u32	max_active_zones;
	__u32	max_append_size;
	__u8	reserved[12];
};

looks better to me. Note sure about the need for model and write_granularity
here though. I did not follow zoned ublk patches.


-- 
Damien Le Moal
Western Digital Research

