Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ED8673A99
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjASNms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjASNmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:42:46 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5D366EC4;
        Thu, 19 Jan 2023 05:42:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjJhV588s+5DkaT8gYCw3zdVQBThohpfd1QS+dXHCPks8NF56ed26lxl6H6+vh4YD+BTM1+BrpiLV3lwJEcE7zXzq8gwiXd2fQjrdQ5mOoW8BlYNbUsi6RcDRDbHINhaoCOmse5QqNmO8E29zhwl9YCgD2+D0lDT/Wfpff5SNmgWYluM1mWzjK1i/RqM3z0DswzVIcppDLeG//fm6GQyuVJQdck8kgiFg9l8u60CRi1Z1D9Csh8uUeWUtXFispRGTk6Sj3CGSzoXlgqTCJtJovk4SIe7oe80U2GJwnWAUrvbMxL0b7f8nJ7GU+v36marpmLJmyHBXbYzzsLHzIpZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMYxtjqP+ASVF8iKNJUPD+IE0DhWZi5Qag6m9JWv+3U=;
 b=BXxvHKYjs6QXZ97a71Sy5G+goycK9iZ3lU3vWixTXMUP1STszWzvFH44dfjX14fF18j2K9DT5aCJRWFjgeg3XFMF1AV8mIxHG3Tg6XFDqnOSrly7cz3e6cM6FwjZlJFjxX8LTpgOzmASM5SH/j+fqZlsXo65gliIzZOoEVOi3sES/xJmXmOyq4bH8QixvM67WIUzuLh/kCwSlp9IYCETva34ngW9NqX3gpcXuBhw7bBm0wYQbbEDPMSvKx57oN8nrYXmcUrzK268vBNy20DY8brKaTkgRaPe0dE9M0j70zmVDIfo3oD/K5O44eFCVapOQ5xrTMmdXgQHVoImxsZj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMYxtjqP+ASVF8iKNJUPD+IE0DhWZi5Qag6m9JWv+3U=;
 b=dsluiopzmWiCKiVNlMRp0WuabTG0NyRsBJRlUts+auh36NdRl60NK+S+DDg+sXK2i6oxQ9FfnsJd4dQbrjLvz7B15bHwScgudLQQsXSUNt6k9I/8r+mUxpf8cqc4jucSsjLlLpHbmyij8wMplBc9VMM7uDwD5FSjt4kHIiy0bP+PWDBHICT5dPaeYyYV/6LOuff8SA8LcvvZy4yI7w7SCydwj7t9D5mE8+Z48DOhaLbC69qsY8b+9UcFMtDcOk8R1AjJcZXWq0HkvsRS88Fvj6vb4jCyqcUa+AQJ5yhQtwhJpxIjVBt3+oA7cANjMXzSt1Z+eyTAJ/n3CuwoaVz5dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Thu, 19 Jan
 2023 13:42:43 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f%7]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 13:42:43 +0000
Message-ID: <e0e3fb48-1c7a-f012-5308-4897bab01dfc@nvidia.com>
Date:   Thu, 19 Jan 2023 13:38:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3 2/2] usb: gadget: u_ether: Don't warn in
 gether_setup_name_default()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
References: <20230119102547.26698-1-jonathanh@nvidia.com>
 <20230119102547.26698-2-jonathanh@nvidia.com> <Y8kfdm9juBi58bnj@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <Y8kfdm9juBi58bnj@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0215.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::22) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6f6fda-837b-4351-9882-08dafa230a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cU7sgmaGwQy3xX5MP/Vp8oQMi8f7111DgPnyZlSWsVR7UZJHN+QkwVj89w6ZsHWqYgW3tuJFfCzqlzgexVxvBA79smJ6ElAAuK05eReO8lBRAY1Q3qWY0P3RvyWbwzlwLpUa7tiNEoFR0W+El1qQi5EEr+gFLqJIFZhvrslP1f+3ARtQQqdXvDJTS5370KUOpLZRwn4Rg3+s3wK3plS3f8j8rhmwMkPEkVoP4kW02m2G2n7AUlHut3b1z7Wh7Z6vQckGioFyJDurCPtSfMAQW9WsQFZB6KVX3ToiYgO2KJbFOyRj6jqpgmVshCAWkTDl23TU4wHRPHhQXIs20wk2zbMO4WdBSbcrfUB1x92KdFSPEDruWpcYcrL8mEjysHHbzaVMlHToXTdG45hztzQGKwzb9AAxucpFRfu1hrfwFcaOPQpfsy+g9tycQze2ig6U36njz6m9p/CsmWiIzJBu1INjFGZ62IZceLjOJ+lndSlCgKeCM0LTtaFFI5q7s/uHnw80xtPhXu78eSEGtDr+dUqICoQGeEXPGvmaB+/qJg/Gqi++AU6CKD00rpaUJOkI+tU6W/PIaPTxP144/u2UVEJdhGj3xh0hqOp5l50+euTBZ+OP1TzsoW/uF9ynzQ1s5Y6ZVJa5WHR2z/1kk5Xa6KGiemJKKesoVNr+PhlZf6ClRCCd62n8PAZbKmsQBlII1Rn22N5MAJUFWb5Ljf0s937Smzz3fVcy8fa48YqXsNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(86362001)(55236004)(53546011)(6506007)(31696002)(6486002)(478600001)(6666004)(36756003)(8936002)(5660300002)(316002)(38100700002)(4744005)(6916009)(66946007)(66556008)(66476007)(4326008)(8676002)(41300700001)(26005)(186003)(6512007)(2616005)(2906002)(66899015)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWpUZmYvVUYzRGpjRGZhRDlzV2NUczhGZXI2dHFITlFzRUZiMitIbFNmK0hV?=
 =?utf-8?B?UWVJSkQzWUl4U2g4cHh2NGZUejkxa1h3elNkNXQyY0dabVlvQ2ZBVFYxZnBo?=
 =?utf-8?B?QnhBbm1mVDErREV5azhuYUw1bmF0bmRmL3owYkxiUHhzbHR4NXhQdnhWdEFV?=
 =?utf-8?B?YjlNYWxJaWJDQXNtZ3QvZU1PMXJ0cnNGa1Y4Y0JwMnh3RWlaZXpJWmh0SnNL?=
 =?utf-8?B?amh2TFJPdElNZnRHdjBlTzQ1ZWtPZXlqbXN5TTJORUt2UnJIWEZnb1FlMFow?=
 =?utf-8?B?OVBGZWhKZmZEbnZoY2Zqa1NiRFZPejYrVG83YVBvc2NzUGlMbGJuZU1CYXJY?=
 =?utf-8?B?M3hpdjd5K09HeWVNWWIrVlhJTWkwOVFPaFY3Ykp2V2dZUFlQVzR0UEhPc0JU?=
 =?utf-8?B?UnZNWm9LRjZEamp2L0NQYWxENGtpN0pDYUgzV0NyZkp2WW5TaGdzZW5jaGpv?=
 =?utf-8?B?cnJPYzZTNnF6em5uYXlmR0dHcElUZHJiRjZVQm1BaU4vVjJjMW9LT3g2QUdX?=
 =?utf-8?B?Wi9zNHlRWVR0Uk10Q09yY054bjVidTFSZVBZdGZVOEJiRTQ3MDMxalFRYnIw?=
 =?utf-8?B?aWlBV1B1bGZxdC9QRVJaNmdaZ2h1K0xJbUp2cEU3Zk5CUmdQUCtpcUZmZC9D?=
 =?utf-8?B?M28ybWlRT3R3WXNJalZoVmt4VjNsTktuM3lSektxWWk2ZGZnV1JUN3h4ekpQ?=
 =?utf-8?B?YVJpa2hzdzFFUEZ4eTl5L09TdVJmeGQrQ1pkKy9xQTNKREYrVFc4bzJnbUxX?=
 =?utf-8?B?T2Q0YkVnVHRPRUswN0QzVTJGUXRsNlJ6NmtaY1BkRmxOQ0cvQ1lFajg4WGgv?=
 =?utf-8?B?N3RlQWd4d0J5UGFQWkZ0RUpUNWtES2kvbmVBb21yMTl2WXRoRmhaaXRKWnVa?=
 =?utf-8?B?TGtValNVNTVEWVJDc2o5am9SVnU0ZVNZVTB0Q3ZQMVU4UmFoYTc2c1YySWJ3?=
 =?utf-8?B?MXhmNTNoRVVnL1V2ZitqSzVGbi9PZ2swOHo1d0l5WTdDbXFnOGZjMjRRc3NC?=
 =?utf-8?B?TFl5Zy9lK0tSYTRybzBWV25Pbnc1cVZZRVlndk4yS2pFeSs1ZktCQWFONHZ4?=
 =?utf-8?B?TDN0RWc0bzdsVlhNWW1QYWg2SC9sRzBsdU1SNGo1dnVTYmpCQTRvYkpNMzRW?=
 =?utf-8?B?emxqNEhRMUpvVWlKRGlmZGVGZFhTRzRMSTVMT0tTODZid0dxek8zQ2ZsNlp6?=
 =?utf-8?B?NlI1ZVc2RzZhbUQ5d0Z4VEVBR29wMHZBb2EvMmVzd0o4M05WSWNUNmVOWnNi?=
 =?utf-8?B?VlR1eVFVeU5oUWxPMjRKbW9xV2VvS2QwcWcyVlBpKzhpak5NZ2s2MXY3OFB5?=
 =?utf-8?B?aGs3NC9wSGFvLzY0MlA4aXVQZFFpZi94MTkwcEYzRU5BNzh0Rmw0UFM1d28x?=
 =?utf-8?B?RmxUdFVXKy9MSnAvaldVaHlPZzI5TFkzdGZDM2Y1RUVXRzlERldySE9sa1B1?=
 =?utf-8?B?S2pKSXVkMjQ0MTBkVm1wYkx4ZXFNMkNjMnJUTnJEWjI5dGR0ZGlGd1NOaG5k?=
 =?utf-8?B?eERzdUZsbkhORE9JZFdNVEJHQjcyWnlnN01sRXF4RkhsZVNyZGt4ZDVuRzZP?=
 =?utf-8?B?WE9va2tiWlpsN2gvS2lQcHR1SkpVVzZYamRad2lzUXgycXJ5TmgwUEluZnph?=
 =?utf-8?B?N21ERXFRRzlESU84N2dSbXZEdFNBd2I3QnVFcVRMOVBaNUJpb29ZOEJjS0lv?=
 =?utf-8?B?V0huNFJuaVo4d2ZmRkwwbE45UjUzYTdGelErR0p2d1VTYU8vMkxnK1hEUEpm?=
 =?utf-8?B?WS9pUGNBeTZuQ0N6dFRqUnZYZ2xqQ2I2NDR2RFVmM1kwUGwvUkxRV0FSbzgy?=
 =?utf-8?B?bFRpU3JaUngyeGExVTY2Q0piOEh2QVZqNjV4dVg3dGhFTWtIQ3BGUVVCdllI?=
 =?utf-8?B?RmE3ZWU2QTRHbHVOVHAwQkc3NHg0TFhKaFJvQTRScFkxdEFpbUh2OEVaWXpo?=
 =?utf-8?B?L3N1cVZXWXFsZzJwdWU5SFh0QS9LZ3hXMGF3L0pueVovaHdpclJWcnJ2Ym5O?=
 =?utf-8?B?TFlia3ltTVRJMXJ0QUN2MnRUYmU1bGdCeUltQ2dIcDFBcmdSRGZ6dE9HcktZ?=
 =?utf-8?B?UnNDbWtmWmwxazl6cTFHTUdKeWJ4RGdqUDhodFNHcEg0YjRPZUhRdkNzYU9Q?=
 =?utf-8?B?T3N0MTErU2E2Zm1GZ0hKZVZoSXlBNFNqK3h2Sy9xTUtnMFpXN2t1Zy9kNStp?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6f6fda-837b-4351-9882-08dafa230a7f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 13:42:43.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 170puEyT/jSCVypGXe+x5DRIm/kXQKa7hi1gY6RGpgUYReYqX3A1SM8d2M35cm3bYG6GuoJmx0RVcyJtceiLJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/01/2023 10:46, Greg Kroah-Hartman wrote:

...

> In looking at this further, you are right, the structures are not
> initialized properly yet.
> 
> So move these to a different function entirely, they should be in
> gether_register_netdev() instead, after the device is registered with
> the system.


I wonder if this is even necessary. Looking at gether_register_netdev() 
it already has ...

  status = register_netdev(net);
  if (status < 0) {
          dev_dbg(&g->dev, "register_netdev failed, %d\n", status);
          return status;
  } else {
          INFO(dev, "HOST MAC %pM\n", dev->host_mac);
          INFO(dev, "MAC %pM\n", dev->dev_mac);
          ...
  }


Any objection to just removing completely from 
gether_setup_name_default()? If we move to
gether_register_netdev() then I believe we also have to deal with 
gether_register_netdev().

Jon

-- 
nvpublic
