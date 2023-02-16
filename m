Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C266991E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjBPKmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjBPKl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:41:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9DF7A9F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqFN1zkLgHPzI+NcXGhwaytD48Y5i51X1+oxZzfZFUTLNwIjCm7r3yWPTjDPT5u7HBBqVelLVEgTUFrk3QQ/4HPz6bokc7HdZwbW6T5nCEbwj+dT195encZk8njObc4h/vhadcTgOQqXF+5vJAEjtUfhOrAY/egVpazOp4Deuuc4ZRkELXtsxSMzxWgw1qvz6mos/liE8o9BsDtt5q5uoawVTTKlJz8X11YcR3ySSaTtkYTx/2q3aHTKg5f63WVXjs8b4OXN2S9vtNPLBIobrzMZEgB4443xxQs3NQA2Pp897tnrOWByLnyfJYtniU7pnQbhEbYS1vpnz+4viHGJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kvI9XfC9BLEmSXov9aN1ovmthqjWohMl2n0s4ZsHSc=;
 b=L8nCZmJGde9iJ1wWEnhE0j2NFm3ToFb60g+WIvteeWaDguA/a1h/yCcGO7COMPip8fdPzZ/9TtQRHm9ZcU76rc+KJwy4qTP/lyCi9Pfad3oJI1Q0ojknv/GqLNYYKQe+uWvKsu+Hi8Wun3doSi6RP4txXoETwrbvRnPIBMb8Q30uJDssmT5SLnqpFBMFW/W3dV9RR4lEc2sLNrNcGquVy0OJhevs93VHyMXEYXFYbLQAxAntj5s1LUdzORgrgz2oVYRiPAjBShR/ahPS6+bDKVI9ARW6G9A+wH8OP2imaNCgq5a03bcslzNCHb9KE/nl0OfeNH76/Jq7WLEBtEwUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kvI9XfC9BLEmSXov9aN1ovmthqjWohMl2n0s4ZsHSc=;
 b=PdlXXUdAAAjt8DdhvNc/w+xZdC2CjNdiPes4JY6/P5qRz9SLU3A45W0x3IkaFJAgJ35e6Z/n5jlktA/y9n9OCPOEG1nNc/t5gMDIhv70Dzm/btniyvuFvQolZK/WT7rjNY+cxwZ5hA6JUf7qcLWbxsqpznD7fdMixKwCsAoA9bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (2603:10b6:a03:aa::24)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 10:41:07 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::dc39:38f2:85ed:4e2d]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::dc39:38f2:85ed:4e2d%7]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 10:41:07 +0000
Message-ID: <2e2c9362-1f4e-a183-e619-c5dc3e56324a@amd.com>
Date:   Thu, 16 Feb 2023 10:41:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Reg the next LTS kernel (6.1?)
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Theodore Ts'o <tytso@mit.edu>,
        Michal Simek <michal.simek@amd.com>,
        Kris Chaplin <kris.chaplin@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com> <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com> <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com> <Y8GFYEnIy0Wbh/n6@kroah.com>
 <Y8HPw2t+TbdXa83C@mit.edu> <20230114071412.GB5088@1wt.eu>
 <Y8JnHyKNTHMjsHSb@kroah.com>
 <CAB=otbS2uwfm0+YHMXXY3TM94V82LtxgcBXGZq1Zxbvd36Wkug@mail.gmail.com>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <CAB=otbS2uwfm0+YHMXXY3TM94V82LtxgcBXGZq1Zxbvd36Wkug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To BYAPR12MB3398.namprd12.prod.outlook.com
 (2603:10b6:a03:aa::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3398:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d893101-6cf6-4288-d224-08db100a4f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rq2Y2jjQwJBpLGEDFgFxS1oFaCwk3SVwPEsLj7kNx2WbVOpIV9lZGCMWB/h4PL84K8yCc7gAf58wiPkuloflnFgRsssTEq5BCtzahSat6buQC6dTtDns+1VJmE2lFg6Abpl+5381LdB0lFBLcC0IXYt5ePxxAh21n2uwXGrBXWjKIRVswVN+4f2M3pjbKO+xTsqzslSM9RameXZPLI6+iW2Xuws9LnpIxG+BOcdEN9KRLiI7ZAVHy8lVb+7c2+bcUfqbFv5ctKVdo9Xnk8oamQQLGkyzZ0WMezQDvdXXadRmB5/OKe53eYevav9zarBXCozoRF4cJ29z6vzyhAUwOHckmqHLBkQ30ZNUBbZOmUW9HHMWZrvYdznU4saNI4ELBWGZxz2cskND1EYp3y7CUgkZ3tuDNlQXo0EcxyZHWHFJXHYyDq88TqGSb1w3JDK6yBnMzGuQ1vbWvlrZz9n0s1lPOpl6rrQZy9O/ngdjYsP1AbL9aS9AwXyfXN8qe4LH9NdkykVeJ5ZXjiglwtGKHZI9tpsB12Bn1BDkEzcEPese2YnQI+Pp3G56DJYh8Rp7IOoYX2WIl7LYMD6MiRxl2biFXBlZujkCm9RE1e/a51WEEp4acS91to9Bn4hLhUN4DI2KmmBwM4jUgYkBI+MR8fcSz+oHRDBVcZktmSrByUy7VQhPadMszhtQ+nEquZDPk3zrxem84DMp3SvhGPd8oM3E2JO50zlgTHLAwD6Gu+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3398.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199018)(31696002)(8936002)(4744005)(31686004)(86362001)(44832011)(38100700002)(41300700001)(5660300002)(8676002)(4326008)(66476007)(2906002)(66946007)(66556008)(316002)(6486002)(2616005)(966005)(478600001)(54906003)(110136005)(6666004)(26005)(36756003)(6506007)(53546011)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UERhRi9CYnJuV1AwaVk0MmYzcUVMem41aWRkN2JNeUw3bkFIdFhjZ0EzZDNr?=
 =?utf-8?B?NUQySnk4b0QwNW1CTG1jNzdHUWJoTU5xOUx2YnBrQlcrSlJHQ2QzcEttSmow?=
 =?utf-8?B?bXdSaE1QNE5tSEhYMUhhMEtmeXdpekhaa3pxVE1IRS9veW8rbGNRQjdweTNM?=
 =?utf-8?B?MkJ6ZmV0eUQ2Mk5WOTFNeHBheU5sY3FFU1NKRm9Za00wSENrRzY0UEQzNE5S?=
 =?utf-8?B?cGM1emdjSXRPMUNxb2dHSktldnhtejYyYlFSWWdhRDBwdks5bVBVZ1VtNTBX?=
 =?utf-8?B?RkFSTlIvVFN3UVVjL29UNzk2QUFsRkRTYVZ6OVVRc1B3Rm4xQ0FrTUp2OGRF?=
 =?utf-8?B?RzJqeHhZMFQ0czA0TllWb1J1ZXRCZkh6ekFyQkxwTzRRa1Urd0R1aytwQUN4?=
 =?utf-8?B?dXRmamhwcHdrMkpCKzNIRkdCUmo5dmREMXVIaHc0ZDI5cDRLRXNVMGFpRTdI?=
 =?utf-8?B?UVlteHY4VHFzMWtTcEZyaTZGM1lVY09zcGVKbk94NjNlS1ZacEJGbnRWdUZG?=
 =?utf-8?B?TE5xNm1jdkZNSnU1NU04c1ZDNWJibG9ZSW93OWt0TXRmRmt6RzJSaUtNR0ho?=
 =?utf-8?B?ZGZBdTFIOG52OVJvYXZ0TVVLdCtRTmFSS3NPTmFjSi9oZElaenB0VVdQZnJs?=
 =?utf-8?B?OEhtMEJjSGJpcW0zcmx1TEF0a1BBRW1ESTJIZzlVaUYrQjdPWHNiZ2JuMmE5?=
 =?utf-8?B?eTZmbUcvTytram1iNTFtY0lrWml6bS9wTzYvSjM5REFEbTdsSzc4S21nT0dZ?=
 =?utf-8?B?MFVUYW1ZMXp6QmVoUWF1TTgzbXJTdStMeUpNMDNWLzEweDF4dlZTU3ZINDAr?=
 =?utf-8?B?RXgvdU53VU8vODZoN3RjcFBVWlZUNjl5RGFUM0F2ZWVyckwzTGJiTHJUUUZS?=
 =?utf-8?B?VmFpTzdOcVl4VW0reHIyV3ZIaldSbXNqWm1oNlF4MFhUTDVKRGQ1V0kvZVRt?=
 =?utf-8?B?ZDRlNTNySXliVnBmRlhRa1hTK1orcXFOVnIvcTN6Z3JTOW94UGU0bVBjd1N5?=
 =?utf-8?B?R0w2SkphZEFhaDJnSWVTVmhJR05ibW90c0NIUHIyaHlwS2ZtT0FZTGRiQ24z?=
 =?utf-8?B?VTBQVFZodFNkYTZHbDd1Q0gxYnhkK2ZTU0hwSnE1SmZnazhlWkZVQ1Z2YWFm?=
 =?utf-8?B?VTlsNkVsdDR4cDBKeFQ0WG4zRm9LMExWUWhKcU1VYk9rMmY0UUFyOW1OVEtF?=
 =?utf-8?B?angzMDZjWllaTkEwWThCRGMybFpsRWdSUVNuYTlrSm5xTU5kOUIxUVZwVTd6?=
 =?utf-8?B?SjM0WnZ6aHdtaFlOcGNINWFhSmxObnphM2IvcjNsU2lndlNGeUx3WXM5MTRn?=
 =?utf-8?B?ZWdLN3VVOUQvbjFvSGJUbktYNVkxeUN4RFJGVnpHWkhxTnZCRTMra3Y3SGdw?=
 =?utf-8?B?Q1dJQTd3NElaRnorbmVHZVdNbzhTTHdyazZmK3IvOHpDV29FZ1lBV0trdGIz?=
 =?utf-8?B?Q2xJNTJQSWY1NjRxUjFteWJTZ01BK09nOU9OaVRwUzRUNkRwbUgvSE1KYmZD?=
 =?utf-8?B?bG9Sc1hkTXUxWGJBM3hhci9aK0ZWcy9TcjlQOU55VGpHR0puL0JybG1GQkhD?=
 =?utf-8?B?R1ZDSnRxcU5VeDFMMGtsOUs3VS9EMXVva3JpRjZjRVNPaE1rYXYvNzliTTY2?=
 =?utf-8?B?ellxRVc3T0V2TG1aWnhrTXhqZE9HRjZ1Q1A4NkJ5ZGlhT3Q1dkpMZCtjSHJD?=
 =?utf-8?B?ZDBGUm9hbitFbjduRmpqY2hCOC91d2lvVnBQYVhvZEFJN2dtZVcxRjYrdWVz?=
 =?utf-8?B?UWVuUElVSU5UTGVFV2M5YVVPcFlPNFBkdm1EODRWWE5zczkvOTI2bHZIZVZP?=
 =?utf-8?B?Z3U3UjkyM1N3WDdyRnoxalAyc1llOWFTM3pXZENZcUVMSFRMcVUwSXVlWmxm?=
 =?utf-8?B?ZFBNZURxVmJnS0hWQktZQUZEOXl6UlozUjZiSmtzWSsyOVpQclVjbFpiUTMz?=
 =?utf-8?B?Mm8wZlI1OGMrWkd6M2xBUTdsSHJKTkpYZkdrNHV0TlZESjVLSEE2blVmY3BW?=
 =?utf-8?B?Mm1rVXJUQW9PaVNtTExKa0ZiWjQ2Z0FOamI1bTJSN1VwZEN4aVhlTklMUXAx?=
 =?utf-8?B?N0o0L0VHQ0dOTnJLZVlqQURBeEhnUkorK25GblF2aVpWQWhRNHN3LzdwVzh5?=
 =?utf-8?Q?wNWE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d893101-6cf6-4288-d224-08db100a4f3e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3398.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 10:41:07.2041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYsr4kCbJ7MI3SdFHySftqcKa9LFfNn3/zr57qDUYVbTZRLF1qNkBZcKxXqT2qKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2023 06:27, Ruslan Bilovol wrote:

> So, is there a final decision taken on what will be our next LTS?
> Went through https://kernel.org/category/releases.html but it still shows
> v5.15 as the latest LTS version.

No announcement has been made yet on this - my understanding is that a 
greater volume and community involvement in testing and feedback is 
required to indicate the quality of 6.1 (currently 6.1.12) prior to Greg 
making that decision on behalf of the community.

Kris
