Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2BF7282D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbjFHOhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjFHOg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:36:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA38E57;
        Thu,  8 Jun 2023 07:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nusk3HZ6kyBT6fM/M4GE27lSm0C248DN/6U9vwftCexLPQWITmrqZ238ZTbCO2gXoeqLAoiDAjOj6JsQcyCoI2dEHZY5aeaQ95bAXUNZallnh/X354h6Jd3wdG4FokQWg3WKwrvr83QKg7dnGkBG0YG+y6OylNAIGP3NeSIgp/qjJ2j59XFLznzY2My1evbFsE7WVy7jgwxM0ZffGB2V0/Xfd1ZM/sQweu39+0MW05mr1vp1zgrM5lFbdLaSloljpfBCFAJnVM71sm3N12PLKbE4FNPQkRR7Q81cTDsjCyUpiPAEKLUYQvRYMEGE4xQpGsdnJgD5AD2mup/ydaVEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWQasI7pqDanYzTdl2LxdfkKDAZhg5DcwVnZ8jotK38=;
 b=RpbSYpRdKJbnAcgnL7lC6aKkkMMyess9ZPZbRoTwVZaYe+c2UGpjOmyD6IBhaM7t3rnNuC/L0dih5+FUqwSvvISAkA68zXr/Xk12EICVXb2GKLZRlRf1W3wa33sK3fUgjZY4LWjtYRP+7w2MfW/i+AZJ5QunMlOxDMXnyf6iTvL5RAX75ButAUi5alY/wiNIqE/UqHhoxauJi4lQKP5x+NhAqNS+ne+MWphackG/jRgns+QbH+rkVFj3QeJeJh5mQCPDMU0lBwMEuQgNJkfYuciDxLEECyJgzZEpQ9AryaGuJpvDS5+w3yNPsepbng4R3HsqdBabAhzsMLGeRrpAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWQasI7pqDanYzTdl2LxdfkKDAZhg5DcwVnZ8jotK38=;
 b=fxVA6h5Qfbv5GUftJu2izw07lcXmKF998ilTYOFtv33T8DTUAWNoeCtDWIrxuhYrnuSGEnTUvAqsYPi2sALfHUn4G3Z8nLLIPl8vGTVoWHzX6ldHQkM32a7wxnKxYAAxVD9gvqIew2ghtdTERFNrAnRdhjc1/illZl276vfQsTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Thu, 8 Jun 2023 14:36:55 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 14:36:54 +0000
Message-ID: <80c27ea8-4d82-a41d-1ccb-17d8da974faa@amd.com>
Date:   Thu, 8 Jun 2023 09:36:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 03/26] cxl: Rename member @dport of struct cxl_dport to
 @dev
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-4-terry.bowman@amd.com>
 <64817846759c9_e067a294f5@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <64817846759c9_e067a294f5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0549.namprd03.prod.outlook.com
 (2603:10b6:408:138::14) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e2afec-9f11-4645-14e1-08db682dce4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUbgu6xgDGghThJNyXwuLj4glgRV8BpXnOWSAiwcVtUvdFt72Nd1+UPKqExCk2vi7SA5j73nW3mrUNqyKtMcliK6KkFRsi737GpEFQqddxC5vGkBbL5thBA0KA0bgN+csDgmekgCMTJoBgRCcw1yCTG+7A+qiU7ghwLLxiGekMCiXSUY+ExzuSHhHXKjxLPa3UJN78DZivlSHiISjnN/xpdPMcYDT+1WYl6+t31RUUdqBh/YtZmQWC1NTJSBzc9oD4TYm6y5NFjhQgzyyGsNV69AR/WZucUtYa6rPd36vO5Rj+Hhzvd8LYUGbiZKqeWXe/9yA/aobEtZ/6QwgeLux9k1xXgGRgllQvE8kulhAXAkKMKiM1X/19AwuGBmjVhjvzsj3tVHFYViOnfsLfsqk/JeFIV4EDakq10L6Z7OmIaPk0DMyUYr/9gQp89RiAeooGpDsD3zS63b/IhTBt2fn4l9DAY++MPhCvrnNLwtxzPtETKU3YsSA3gt3U+cqHCYkiAWh/9+bWKXCrZsYC3ncfRA1x06T1IK58ywtpVQBb5us3QItmqXhw17O1/TUK3gQbGjEqO3h8iSS3cTlJtyjwBW7ePpmw83Qma+YAtndZqKT2e8ZtSqSJ9zddUuDxCc/SpLUrIE7jGI078YlwlrCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(8676002)(2906002)(316002)(7416002)(5660300002)(66946007)(66476007)(4326008)(66556008)(8936002)(41300700001)(6486002)(6666004)(6506007)(53546011)(6512007)(36756003)(186003)(31686004)(2616005)(83380400001)(478600001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxrRVpwd21hUTVtZXBTQWRrbG5INHBwWjlUMDR0TEFKbjlrMTBROXhGS0xs?=
 =?utf-8?B?eHEwZENRdVpMczVxcDkzTE4yMCtURkZxak4zdnZZY0xscWRiL0JBeUE0NmlK?=
 =?utf-8?B?WGFvYWM4cStvbThqcWhmcDJoUlBYd28xeXJBdTU1Wk55KzhuWUZ1V1A1dkF4?=
 =?utf-8?B?WVQ2SnB5YWpkSUJYUktJV0xqd0VzTThJSkFkWEFLWk5MeWZIMC9JcGV6OUlR?=
 =?utf-8?B?NXFDcFVJakpmZithaXp3TnF3eDJZdXVpcHVuOUl2cDNqdHZZSTY3V3Vibkg5?=
 =?utf-8?B?Sm9PYnJkRUNMMmVucU9GeEJoSUZiNUVhZnFqVkQ1aElqVjNTYzRiMXQ0MDdv?=
 =?utf-8?B?bUZKRVdUOExmVms1a0IzcFE0MVFLZnM5c2tzOVplSVdYMG9DK0dXUW1WNzBY?=
 =?utf-8?B?Ny85MWtrZ1cxR2VKd2h4amRpYkl0UTkvREdJWGNDS1h1MWh1OFNQY2ZhaFlo?=
 =?utf-8?B?M1dtK2Y5eG5uamp3dThWYUc0amtodXBoTjVZQnBCN3NYbnBDdTRhKzE2YUR4?=
 =?utf-8?B?TVhEeHM1VHVIK21IL3ZMajB3VFRCRWQwTkpLRDc1L1hDZUZkY2k3N2FidW5O?=
 =?utf-8?B?emlRVkQ0ZTJQN3YvZ1BBRXBEcUc5K1NIdGwvZFZ5OEVzWHhIZW1WS01KSm5F?=
 =?utf-8?B?M3JOWVpzMmNqMUJ2Z0lJV1NVQjVPZVRLeVR4UTBSeHFxNXAwNVJNREluVG1z?=
 =?utf-8?B?UVFteTJVTkI1UDBiOXFxaWd6SGtpVXEvakVIYmZWODU4YWNBL2thNXpza2gy?=
 =?utf-8?B?bjMwUnB1bVlpdjJMdmlMZVNodlg0Nm1wUDdFTUNvSFFyOXZhWU40aG1INWZN?=
 =?utf-8?B?cjVueHI5ajJ4bEx5WGtiR01VVThpVG5xeUR0bkdzcnFuQ2pVd1BkaXdVdkJz?=
 =?utf-8?B?aTRGOTR2RlZjL2h3QXhyUU4wK3pJUTFJUElSWEJhV1B1bXNuR2VIVGVYOGdT?=
 =?utf-8?B?c1dkTlBHK2U1YVN3VGlBWmFHM25ySGlkMlEwUHVZVWRrRGhuQXVwWjd1blFl?=
 =?utf-8?B?VVhZOGtYOHFqMmJNY25lZGxKUEI1dlcrTXpZL1ZSNlEzTVBvUGQ0YXVyY2pj?=
 =?utf-8?B?Mmh3MDBKMmF5WVZ0MktqcGttUGRBekZ5UW9uMklxLy94VnlmSzd6bzY4MFIr?=
 =?utf-8?B?RWs1R0lobElYVHpOVldCaTZvNkg5NFAxREQvTENOU3dlKzdXWlUwNW5aZmpJ?=
 =?utf-8?B?MG5oekJMT0x2eUFYTU9BWDZQM2o2VzJDcFpLaDU2K1BWNm52TDNCOFVTcHJS?=
 =?utf-8?B?SU9jRm9aSEpOUGpUZWxaaSthQ1lrS0xhYi9MK3pCUWtiZklxYUxFbGkvbFFp?=
 =?utf-8?B?RnlKTFQ3bkRhUXFMaG50RlZ0eUNySzJtTEFZLzFTYmVnb2lKSUtkUktkcVo1?=
 =?utf-8?B?eGNvMFhKbTV0MUNFQVFTNDBWZW8yTEZybEhmSXRJaXJ0ZTlESmliczJGSVFJ?=
 =?utf-8?B?OE5la1lrempITUxMZWF1eUFJNTFmMFpqZURpdDZ6aWtRT1pqVHU5aVFreU0x?=
 =?utf-8?B?dVRjK0kvZTZsRktzTTVnalV1T2xCbHl3VU1LRlBrNlIvRnJSVloyYWl1SVBi?=
 =?utf-8?B?RDgrNC9yek1DNHZWckQxVUtWNGxTbTIxRUZMN0d4Rkx0RTVZMm1QeVN4WlZI?=
 =?utf-8?B?L2pSQ3RraGhxdU5FdGhCYUFETGRuUDNJYWdTMi9oLzdnd094b0RiWDZoRm5k?=
 =?utf-8?B?Tmx3cHk1RjRwT1U0Nzc4YjhUZGgvclY2ejEvdGRvR1pXVUJFbkNMSkh3Mlhn?=
 =?utf-8?B?cEs5RjVIa0JQRHRWbEdwRlkzVzk1dS9hNldTK3dMQkFrMjR5RmoxWEE0QUFa?=
 =?utf-8?B?VFRCclFsN2kyWnBrS2RyaEtpL0xadVdKY29NZVlhblRTUDU2bUFsK3RPYzBl?=
 =?utf-8?B?dTRIVlFCLzN1amRoN1A0a3hJMENPNGw1b2xFVFpDQnBpdHB1S1hUV0JFMVV0?=
 =?utf-8?B?anZNcW5iNWJQTngyRHdqQ3BoaWVyV01ueVVoMWlCQ0I1RFBRZG16U21IQzdj?=
 =?utf-8?B?Q2NYeDBLZG5ZZGNEOU94aHYxRlVMaTRKbHphbjljZVlpa21TOVV2ZHIyazRU?=
 =?utf-8?B?ZkJFcUw5emNQc2FvOGE2RXd4QVdYN2phVlJEeWU1R3lpbnl2UGk4SVFCQjll?=
 =?utf-8?B?SjBLaTdQaVRLUVhPYXQyY2JybXZTZFgyblJzMmcrWHlvYXRESUV3bDNkTzlv?=
 =?utf-8?Q?xcvcUcH/AlbJDSXiGZpgh7YN1zmZs16jWIfa2r3MPXsS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e2afec-9f11-4645-14e1-08db682dce4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 14:36:54.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzucwwDmvJMqvtPnfKFJfnzN6ea4p0QDsiba62ds91ACKa6Dl6Md1R+UVxaXeUSRX9tjfaRhRQgSqTPp901kGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,


On 6/8/23 01:42, Dan Williams wrote:
> Terry Bowman wrote:
>> From: Robert Richter <rrichter@amd.com>
>>
>> Reading code like dport->dport does not immediately suggest that this
>> points to the corresponding device structure of the dport. Rename
>> struct member @dport to @dev.
> 
> This one I don't agree with.
> 
> This can switch to ->dport_dev if you like. The reason for ->dport was
> for symmetry with the ->uport of a 'struct cxl_port'. So if you change
> this to ->dport_dev then also make the ->uport_dev change for symmetry.
> 
> Unlike a 'struct cxl_port' a 'struct cxl_dport' is not a device in its
> own right which is what I see when I read dport->dev.
>

Ok, I'll change the structure member names and code to use the following:
struct cxl_dport::dev  -> struct cxl_dport::dport_dev

struct cxl_port::uport -> struct cxl_port::uport_dev


Regards,
Terry

>>
>> While at it, also rename @new argument of add_dport() to @dport. This
>> better describes the variable as a dport (e.g. new->dport becomes to
>> dport->dev).
> 
> There is already other occurrences of dport_dev as an argument, so I
> think that works here too.
