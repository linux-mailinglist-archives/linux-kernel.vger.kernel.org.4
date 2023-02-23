Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051896A0DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjBWQOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBWQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:14:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C7C43477
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:14:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbOhW10yqbmDRjtdJFt1+hFZRriBZGhdUCHg56wO9LnBtC/ZRSs6Tfn7xdxAB/BtbxJ6LXJNhYWpfzRH843wiukCA3MfNkdK6ZMGTqJ4IvzbDqI3CMp/cmn46YZlcOdFpiBpzP90VoIaiAt+xIPYGURs2Vxt5FtFckwK6+Yn1bRq7FfuEPNXTue2ehHK0Al+jJ0nyiJ1MA/3OOL7t81Jd8akVPkAP0ipaMGMxs1BzqFJicRDg6zBjzcAnmbSWh4PEr2o19GBz0xhkTN+rco94TYz9MbtqhBX53WtW2/kyL+ghK3UORSBVMcoCJb9RebZO/Vw0fyfqjf2zf6V/glwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBgnIFg6PPrpheh2eXbM+bj5GhqpjUtDf1/m4qdp8P4=;
 b=iyCQrHIdCGZVut2AVqn4wTsbAW9aE56qeMIGagQOYbqkos0cidCFmbTECTmOXS5+jJd8ItyM1hS3aO2XlChsAM0jGBAbpHuEwV+lQRnzSastHi+ph3xRDKiV4mliRIFy2FuTkvW7nXXQZlIAeo9FrDFx4QaDAhggaJYXHMWM/i/aOVxSf5T8evkiBK9YWayX7e+NE08YNzt1EVQBbgbrrS/yE3C8c6VwJqjw5GUCwL9SQZjHI/lf2R2AL3Y1eDAZn78dFXbx1OdSiRqVU/HPS0Hn2u7jI8CCwAGQPgcEEDe8HDOueWGs8OjtQwIukQgXos9gFyftx+I1gA0o5/t95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBgnIFg6PPrpheh2eXbM+bj5GhqpjUtDf1/m4qdp8P4=;
 b=ZHufXJmgfUcVtkUvCcE8bXPdpUoW0pvXKglMqC0SEh5ByUoobE+P+5p7Ajcwsbn7CelItB7xMdlWwmN5Rzk/9eUgTTYxh6RHOfVurIZ55jys7tfRnc11YKQ+Db7BMSClBjKLJX7eb7R0ik9s28B+hHNKzDMvv+TzVpHA67kUF/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 16:14:40 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%4]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 16:14:40 +0000
Message-ID: <0c3a11bb-9036-2067-bf73-d18bb55c1225@amd.com>
Date:   Thu, 23 Feb 2023 10:14:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND PATCH] virt/sev-guest: Return -EIO if certificate buffer
 is not large enough
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Larry Dewey <larry.dewey@amd.com>
References: <2afbcae6daf13f7ad5a4296692e0a0fe1bc1e4ee.1677083979.git.thomas.lendacky@amd.com>
 <CAMkAt6pqyOqVd_etLVfwrihEoc6XtS+BaVsV8x934rr4LmOCgw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMkAt6pqyOqVd_etLVfwrihEoc6XtS+BaVsV8x934rr4LmOCgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:208:23d::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fe3a92-913b-4c6d-48b8-08db15b91128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jtixecb4tE+PrZTWoJCW5a8zTqf9aswYjbFW1xHifC6BRfQ6vbHyD26GWqMiyX6n6WTYtLvqwq9AbYWsgbPOSok3a2xTSi4g12k3lfbto0HMiNsBtlT6BZ6Cq9KGG2VtnNs0wPGni3shZLQa9LUJTXtGwGt59jBg1K/Qg6Kt6NwIB4MIJrPv8oYQKkiCECI/XH1+eD6++rVJCOVWgOIkPMndTQit+WFQU1z89M3wPymxhKhYaeoI6pMWzm4V4+h8pSipb/XWpFDCZiExytNJcoOQdUfZakMNX3d2wPo3O2XG0bFWXKu7G7lJgVu1+F+sxFSpKdX097f9BhK3YstwpibeMSBMLIXwSQbvY9nR6o0OCR5JeiJ8PlGOvzG7WIvZQp/UfIenDE46j/aNCLRkuoFKcvxLUK9zyAxGO/WdgiUZxcPMquaoFR+mcpMXgyl772JtF0JN5olAOVt/Rh9AIYng9xoTzDuFZvooGGT3us0s4g44xsRkCBSl/844LJSvuyUw5AAUfQUMYWLUCy9hH6rVyIT1lvTK5pPRKMt1GBat/gbs0V8RJu/sByVPigqApxLKZtzPnO4mVi5yMpI9cMoq/L5sgSlLdc8UDo/1+0v3Xf7nQ3M6TzWGJUcz3sdWWm3D1SbBXydvL0pCNyjRcfeV3P+YD0FD+1FJM5/paOUetbCz4+4MSg4Dg0XLjloHEuVexRi11ncX17BW4ULZB1jgrlhYpcnGHUcHdRtDk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199018)(478600001)(26005)(6512007)(186003)(53546011)(2616005)(6486002)(316002)(83380400001)(8676002)(4326008)(6916009)(54906003)(66476007)(31686004)(6666004)(6506007)(66556008)(66946007)(41300700001)(8936002)(5660300002)(2906002)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1BBWVlNZHBwNGQwRW1oeEUxbU9ScHJnVEhuTkVXTzJrcFFZU21ReDI4OHBL?=
 =?utf-8?B?Q2h6YVdCankwQTFtcGJDQllDL216VE05TEV5b2NGVmNtVU5EUFgwTVVwcysz?=
 =?utf-8?B?dWVrTllhWUpYNWxPdmZlaC81cy9yQUpsaDlLMVFUWWhDdjFDbEZXMzFjQU52?=
 =?utf-8?B?cFJYQ2IxL0xPSkkwaXBGcWcrZnhqOFJKRUF2QXV6clVFMi9WOXhhY1E3NXp1?=
 =?utf-8?B?L0k2cUMwa0NMaGhGbjNEKzdtU01ndWhZSzgvZlRsR3NSL3JEVFJSMEV5bVVm?=
 =?utf-8?B?am9PV1dpVTVacTRnR05DUGIzQ3NrMGg0TGFwZlI4N21aeFE0YkpPbzMvazI0?=
 =?utf-8?B?TjF1eDdYWnp4clluNENqTVp0QzNlUGNraWxwa1Rxdm84KzBuTTRGOHIwS1Jo?=
 =?utf-8?B?MTFHclo3Qm13TGZMN3lQSlg2MUNSN1Y5bjJjZW9OTHRHQytLNWozdjF6N2Vj?=
 =?utf-8?B?akg4Ky9JYWtzU0NtRlNRK2xaRVhSMmg0MUQxTVpSdkJMblZGVjY2bXZMQm5P?=
 =?utf-8?B?bWNVTTUydmlnSzlhYUtFUis4TzQ1RzEwdUJXTXdpaGRGWHRHc1VWMitRcTNp?=
 =?utf-8?B?amlIQS9IZ280b1ZOeW8xalI5MjVIYU5pK2o3T0RsWGlyemZxci9kbUM3bkpy?=
 =?utf-8?B?SnFMRUJqY1Q4MUFhQWpGcUxNUjFTcXBuamp0NWhnVWYvRm9sUi9zcVYzZU1J?=
 =?utf-8?B?L2JxRi9qVFAvRUNzZmN2a1lVZllpdWRqTnBFQytnSUlpZm8vUW5QTVdsb2xE?=
 =?utf-8?B?Vm00RzVvcjZsaFJ2TGMreHVwWVJLZDFFc3RLOERzaDZRai9maDN4U0RYTU12?=
 =?utf-8?B?TSsyQmN6STFQRjl6Zld6blo1TngrNXdwekJxcjMyOUtBd2dId0xPTjFjaUVj?=
 =?utf-8?B?Y2h6cUFaTE9sRnRpWkFuZE1IM29JYU5iVVRHNm4zU2hRbXFhKzdtODV5STc2?=
 =?utf-8?B?WUc0Yko3L29PVnB5cUNiNDBzNiszZEhUUDhjVzY5L0VMRUFUcVdTb2hsTUg5?=
 =?utf-8?B?alFSL21LOWZYM1dDY0E2OExubUdRc29wZkdJUGVaMnYvWVh3Q3c3NWJwem05?=
 =?utf-8?B?bFZ1RDF3T3o1eEtWZHhqcnZQbXMwdE16TUJYSy93WTc4N3BLYWFwOHdoSkl0?=
 =?utf-8?B?TTJEQVBJc3ZnT2FtRTNnNXYrYVBlSFJzcmNRc2RMMjhjdTRiVHkxM3BHZk0x?=
 =?utf-8?B?MG1pQzRKWFBkdXByeUlHUXdadGswaXcrYzdnK05oUU45UXRNbjRXcFUyQmtK?=
 =?utf-8?B?ZnJRSGN2Ly9uRitLQzVyQ3J0Wms1SU1QeE0zRWIxSVJnSnFtTTNrdUNkTmJB?=
 =?utf-8?B?YkQzVFc0TFJaaGJ6RXFwTjY2M3dFN3M2eEZtMlJraFQzNm44Q1pKTVFIZzQ3?=
 =?utf-8?B?d3N6Z2ZHLzlud3M3bDRnZWJZT2JpVXp1MitQYWZaaW5jdmJMWHpjSHRkS0Zo?=
 =?utf-8?B?alFjbG01U0FVWTNXandGRVdiWXZVUmhvQTREaVdvMjNuM1RoMnNaMktGOC9w?=
 =?utf-8?B?S0NBTWRFaDl2NVZndTRiKzIyVUpTbE1BOHRUbklzcWZCWUFvMmpRcGJxZU1R?=
 =?utf-8?B?Vzl3azdUNEoxN2NETUQyTnBDVTJKblgzaENzRVFieGNkS2QxclY3dHdBTlJM?=
 =?utf-8?B?MStHclVpSnF1eDJnZ3lJS1NobnN3dW1mMHNxUjNaRWI3b2J1Zko5SCtHVWFz?=
 =?utf-8?B?YXBUMm9XbUk5am5DcyswM3JKNWdpZC9MVjhGYnY3Q3QyMWNRWnFucWZIUk4z?=
 =?utf-8?B?OVEyQyttaUQwR25NMXhiYzhtbFlmMVJFWXBiRGJWMkxWZjJvcDllZEVzZmhG?=
 =?utf-8?B?U0Z2OVhQbTk2OE5lMFkvN2FjSUJoMUlxcDlVZVZhdEIwSjVBY2Y2YXNNOEFD?=
 =?utf-8?B?ZDdnSlBFRTRTN3FwVDYzMmEwNWk5WnZyTXUrcExBaW0xbGxaUGlkQ05iRTBp?=
 =?utf-8?B?d3o3UzVuNkJmVkdEK0RmMjd2RlpDSWxkSkw3RFJtdVBrWVdLNCtqeVZrT1JD?=
 =?utf-8?B?Vm1MZm0xakdDWGNFNmpBb3hvc2t1U2xPTlY5M2F2NDd6OTFZUk5kbFIrTjhu?=
 =?utf-8?B?SFlaV1Q5WHNPMlQrMXFWamFJcmp1aE9LR0xuYTZIOHAvSCsrVjJkUkFPSTFL?=
 =?utf-8?Q?PQ6npoTgfckdBRk/PqD+P3AhP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fe3a92-913b-4c6d-48b8-08db15b91128
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 16:14:40.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVO++Te7kCAXy0maQNeVpPrGm0SVBsMeLIdWfW3QDWM5mhyVwrz2gbFXjzfZu2db44vDrht9yd4rDdPgAQinhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 10:51, Peter Gonda wrote:
> On Wed, Feb 22, 2023 at 9:39 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> Commit 47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest
>> driver") changed the behavior associated with the return value when the
>> caller does not supply a large enough certificate buffer. Prior to the
>> commit a return value of -EIO was returned. Now a return value of 0 is
>> returned. This breaks the established ABI with the user.
>>
>> Change the code to detect the buffer size error and return -EIO.
>>
>> Fixes: 47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest driver")
>> Reported-by: Larry Dewey <larry.dewey@amd.com>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> My bad. I wasn't testing the return value in this case.
> 
> Should Boris take this patch into the retry series?
> 
>> ---
>>   drivers/virt/coco/sev-guest/sev-guest.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>> index 4ec4174e05a3..7b4e9009f335 100644
>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>> @@ -377,9 +377,26 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>>                  snp_dev->input.data_npages = certs_npages;
>>          }
>>
>> +       /*
>> +        * Increment the message sequence number. There is no harm in doing
>> +        * this now because decryption uses the value stored in the response
>> +        * structure and any failure will wipe the VMPCK, preventing further
>> +        * use anyway.
>> +        */
>> +       snp_inc_msg_seqno(snp_dev);
>> +
>>          if (fw_err)
>>                  *fw_err = err;
>>
>> +       /*
>> +        * If an extended guest request was issued and the supplied certificate
>> +        * buffer was not large enough, a standard guest request was issued to
>> +        * prevent IV reuse. If the standard request was successful, return -EIO
>> +        * back to the caller as would have originally been returned.
>> +        */
>> +       if (!rc && err == SNP_GUEST_REQ_INVALID_LEN)
>> +               return -EIO;
>> +
> 
> Why not set 'ret = -EIO' and use disable_vmpck directly? That seems
> more clear to me instead of failing on the next call.

We don't want to disable the VMPCK for this. This should go back to 
userspace with EIO and SNP_GUEST_REQ_INVALID_LEN, as it did prior to 
47894e0fa6a5. Userspace then allocates a larger buffer and re-issues the 
request which should now succeed.

Thanks,
Tom

> 
>>          if (rc) {
>>                  dev_alert(snp_dev->dev,
>>                            "Detected error from ASP request. rc: %d, fw_err: %llu\n",
>> @@ -395,9 +412,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>>                  goto disable_vmpck;
>>          }
>>
>> -       /* Increment to new message sequence after payload decryption was successful. */
>> -       snp_inc_msg_seqno(snp_dev);
>> -
>>          return 0;
>>
>>   disable_vmpck:
>> --
>> 2.39.1
>>
