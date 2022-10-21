Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4076B607199
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJUIDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJUIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:03:01 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150122.outbound.protection.outlook.com [40.107.15.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FEF244C5A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfXryvEf3ZKd5iFoT7PCNw+iSXk+a8IjhdHYA6mzpByhBq4ZQ0u6fgW6ROLcrJ4xz8QvvEJcgFrgJHz8+IdlH2UpUwyzBGtck4si4OZCo2UDvSIDJt40B0Q1M9TGGlXq70GsMU7jX1xcQKkidTyb5mMYazp1fHLsfxqAxmyoQ8hc4OQOg3HUUoSomS7v/Mz3MPQ7lVDWY0SCIJr8o/ImMhmanup9fRAJ3+oInEYAcnIIv0sMxVRdN/uPW0A8SaETnFnN//HTC+xM6J3y9JqCssil3NYzcuhnN9S0IyUCqtIswF1Ob2RFdYQxILeYRkwVfjmbBud2LVEWwT9Vq9hrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aL203TCkgk/7HSkXr7KZ0wtWkP//ZvSOKoc0iyHdrk=;
 b=YpnCSF0Mze6jH2q0Xz8BlC0cDOVbGQOwPfgE7+aezXlKsdQmWAXwzgj1wA7Oh5k5T8Tt3mFgy72XA4PbOMtDanNJWNeA77K/Z4AYnx0/3xPu67bMBJjzuxTUm8RL7JGMlhTzTioNHqBKavm9RKYTJ3U5I05yPwR20a5n48iDQjZEJv0IUTD/k26fs4n8Ge4OrwXQHry/z42cAIRLFpAlkxiiLXUbZDXdZIcgdN4Wj8AdIPVVUWe7HGwFVjkBwaicbatZcDTj+/ZPMyBv7CRmqsTmc+9WmB0J62i5IAmNhoSPlbV5BnArQN+DMINhX5+kAEzzGwmuFQvllmVeqKcPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aL203TCkgk/7HSkXr7KZ0wtWkP//ZvSOKoc0iyHdrk=;
 b=hNIQBhoVPOOK5G6nKfof0+kQS961bbt6AMrMcv4/Rjwf/JXQeXkfKXRbFu4zLEbAsaHk2ea+bxtTSnYzQ7IrTU9/xgOcURHNhWR1NGkA8AbNTZL6g1ZggIhWjJRpcgHSJuveRRwkoJFx1JxHBnXVdFtpoZ1RLXzOq8t6cdugjFkFfGPqnhQkXGEfcN/Pm1o6ohvTV1UeQA8cJKsvumhfi+p/QlTruL0CpJOeAhwAoGT6i3fgkAm4ZoSy8rifxUCZ4l2GUtjAQC4qk2myRSHg9a6jsb6s7DG7vuqnZqIr5QlCKUjwSCpTH7QX8xIkHhtWnRiA0QU4EPGCwycG/dMj+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB4758.eurprd08.prod.outlook.com (2603:10a6:10:da::16)
 by GV1PR08MB8428.eurprd08.prod.outlook.com (2603:10a6:150:81::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 08:02:50 +0000
Received: from DBBPR08MB4758.eurprd08.prod.outlook.com
 ([fe80::abdc:cee5:91bf:4c78]) by DBBPR08MB4758.eurprd08.prod.outlook.com
 ([fe80::abdc:cee5:91bf:4c78%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 08:02:50 +0000
Message-ID: <0ed00686-4355-7f3b-4c73-cc6b5a0317b3@virtuozzo.com>
Date:   Fri, 21 Oct 2022 11:02:47 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [RFC PATCH v5 6/8] drivers: vmware: balloon - report inflated
 memory
To:     Nadav Amit <namit@vmware.com>
Cc:     Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernel@openvz.org" <kernel@openvz.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
 <20221019095620.124909-7-alexander.atanasov@virtuozzo.com>
 <39FA848F-290D-4110-B27C-8822377E6AA5@vmware.com>
 <627d2c7f-8ba0-2910-a98d-ef42b9dd5ade@virtuozzo.com>
 <CEA2F8DE-DA49-4DB9-95F8-D0864048353C@vmware.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <CEA2F8DE-DA49-4DB9-95F8-D0864048353C@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0701CA0041.eurprd07.prod.outlook.com
 (2603:10a6:800:90::27) To DBBPR08MB4758.eurprd08.prod.outlook.com
 (2603:10a6:10:da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB4758:EE_|GV1PR08MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0080ca26-183a-47d6-3184-08dab33aa609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yb9DwDnn42KjDmMjPAtUlBuq0fiu4W1CtmbIxAqJ5Jcy7pqxGClNVY2xQcYLoYl0PLKJqrE18uF1Y/ony3wjPwklH6GRqmIzPB8c0KhYnUg9r8HHuAMSczUL4eedCU81udSGazgqspMkgBayvcQVhtKDgiGKWHI44sMhXnSbzGlN9U9BXr6DVxU29As1em0IUR2qZFWZC2vT7iLbb6qdbqliWQT80c9iNfNP277jjrBY6s/SF8UPNmRoJkgdCru1qX6fesLavybjwTGhB8auSIk4gDVoV2M1F1XWHlss7kcr+Ij8XaPyxfZI290xX62A3hbE6VSErJK8DBI0muJEF6pfhHe4sIsla0SIFxUvKQbn1iKR4D+Owl6FGA/ZFyDmAkauljSGjbY6DdpP62uWg5S9bNfzaIFHun5ygGOBgE2qdnjeKrwygr7zV1u6NMWVFCnlNNp9w8/1CxSAo7EIJaPJ2ECAy4QJclnjUUvt+dUMweVMcILHzTGoTGZRijugwHbCmN2Ktjbo4G07vhCZ19Gf+VqYNJd7ch27sn/CHG7+M0TuCdVRn+8eQwj9Z0z0iZ3TjTF8BbcQbCQwgXNRJUXenPddRKquJ2AuHkZLiXQ/g1SdCZFgJNDPeI31h3Q5/EUj1XiHpfnovKVaUDkAYCHaulp7BhrumZJ2+YhYt7N8WF+Ocor8iZy5ixpI6uZOqBkil0BKz0o61lZvOLdb1Rp5MfNxuqk8wFQ6a2/j8ZF0vXpcvNPSnnRv1OYVuGqekvFTYOiDJOStpKtOrbZaoSSSG7MD0/LwHzOFVj3UUcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4758.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39850400004)(136003)(366004)(396003)(451199015)(31686004)(86362001)(6512007)(6506007)(26005)(4744005)(66476007)(8676002)(2906002)(44832011)(66556008)(41300700001)(31696002)(4326008)(38100700002)(5660300002)(316002)(66946007)(36756003)(2616005)(8936002)(54906003)(6916009)(6486002)(83380400001)(53546011)(478600001)(6666004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhiNGcwVWJBZ21ROFlGdkQwRXpNdTZFQ1lzaWp1dDFwQTN2K0dZeWRlTm9w?=
 =?utf-8?B?ZWgvVW1BL3FXS0Iva1pVN3ZEbXUyVG5IZkpwcnZCU3lXeWpPVkRSYUo5Y0hS?=
 =?utf-8?B?OGlrV0MxQ3BlOEZiNjdOQWphcXI0R1RVL0tQMFhOeVphRXRmRm8yVmErYlJM?=
 =?utf-8?B?SWtLaWd2RlArNGFRZ21xdVVkeW1MTCtoRnRYcWZWdHZiSDcvOEJ6dXQwRnhP?=
 =?utf-8?B?MXRuNWdrOWgrQnB4djdkcVQ0bmRSazV4UjRaRDZOVjZGNjc3NFZKMTd6QlJQ?=
 =?utf-8?B?RVF0ZzEza3VCSGl3TzRZeTF2elBkbGlhZWtFY055eElyMWFGU0JlNFczOHdG?=
 =?utf-8?B?S2VqVVBuWmpKOFVHK0lERXNUY29uemU2ODZVcXFHY1o1TFl6UnRpQ1lqN2o1?=
 =?utf-8?B?NHFFOTBNcXYwbjFjL1o3em91R1QyZjFXLytnOTJ4TytoZ0VuWEV0b1lLYndn?=
 =?utf-8?B?OTJmVDQvMTNuVzJ6REx1Q3lnTjhpSEZJLzJjWEx0cGRreWZNdU95VC9PdWFm?=
 =?utf-8?B?QmVRWUFxZ1dMeWhmTVZKUE5GMUFrVXJPZTVyWGlCdWY2dXZZRFBGQzgzL1RP?=
 =?utf-8?B?L09sL0RrbnVLejJiUWRXaVBaU1RHY2lyZ3lXYjFxSlRCdHMwb0JJaE03eDFQ?=
 =?utf-8?B?aWxBaXJYbEJKYWJKQ3dQS0Jha0ZHS2JoTGpyY3hkRkZoNkZ2RVJFUytwOVlr?=
 =?utf-8?B?TDlaQnY2dlVwM1MvN2NQSVgxamliMHNINGZVMURwMlY5RE8wQ1VJazVub2hX?=
 =?utf-8?B?b2ltYTJrVzRDUFRnRmZvV056dnZ5aG1WdncyZE9CV0Q3SVJpQ040V25JQWly?=
 =?utf-8?B?OHN6OXJCM3krc0pOb0FiM3JEendCWG9jVXZJQ1pNK0ordGdkSU5DbUsvckQy?=
 =?utf-8?B?RGR1RUcvSnFrSy84OHNoc0J0eTVuZlNDK2R4S2JiK1J0djlUK2RzSWdxNkQr?=
 =?utf-8?B?OXZDMGFnMWdNNU13V1FKWUFORzhiUVNDQi90VDc0QTVXZWMycTA1NUNOd1ox?=
 =?utf-8?B?Nk16bDNnNVYydWdaYUd4WUdvUTQvcmlZSW5WWHlwMTh0SnpxYzRyKzJUS0gz?=
 =?utf-8?B?SmNBK1A3Y29OR0l4ZnIvWEZ4SUlBdmYvYzhlTlJBOHpYaTVCM2FiMWlJNTJP?=
 =?utf-8?B?QnBMeTJtcmcvOEt3d2NwcEJzbFhvSGpubU9EaUg0bk1XYXJJeVhtdEtPN3lD?=
 =?utf-8?B?MUNwdDM1VS9ZUWdjZnpVNEh0OE14YkxXNWZsdWhGV1BkdUYvcmxJTzNNQUFC?=
 =?utf-8?B?czRBd1FlNlRHQ3ZMTmRZbU8ydG1Hb1BsMTROdHJZVUxKTTl2c0NDb29wdWRs?=
 =?utf-8?B?NEY0QmJWemhDNzNKT0sxNnN4MmhPblZ1U282VnRITGUvVFNBSVQ4ZlNWeVJW?=
 =?utf-8?B?cEl6WjdHeUtFOUx1cEJOdDhxaDRYM1daUmMrcHJpbjlSL3hOaVRLRVE4SEpw?=
 =?utf-8?B?MW01VXFXeXJTcWpFdTR1YisxMmU0SXA1R0FpOHlGUDZCdHRWaTVjOGlhSm5L?=
 =?utf-8?B?QkxCYnY5Y21sMTE2ckdmN0JDanhGcGJqai91a2pVbzcvUkFCQlZPYXFDM29P?=
 =?utf-8?B?dGtuRG5haGJDdlFkdndkN3BlS2FVOGJjV1NXbGsxYUxCRjdGYkh5UmRrQmVF?=
 =?utf-8?B?S3Y1dTdIYjByT2VxNE04RGZ1OEtuWERLenNWbWVSanZWMzFjYTB1ODVWQ3JS?=
 =?utf-8?B?ZHVOVTBseGdxZURuM0c1RnhmVnV4UzZqZlllVVFJc2dnUFlVQm9RNTZWU0l0?=
 =?utf-8?B?LzFvUURCWEVXcWNSby9hOHZuMHAwVFZKeUpRcG5lemRRNlR2ZzVWK0pzall5?=
 =?utf-8?B?TDh0amExSXNyUkJNUC9WSENwZWRIQW9aUE1yM2ZqSW9QdUZMb3R1KysyR1U5?=
 =?utf-8?B?SHhmdXpULzA5QVkyUGM3RDhETk9wV29oTU0wZnA5bEJONWs2bDZ5NTZwMkJ1?=
 =?utf-8?B?TnB2MFA0MnVZYVcrUjBGc1ptUHVXTS9TUWRnZ2plZmc0NUhWY3FZU2VEV08y?=
 =?utf-8?B?L09iQ2xpM3ZHREw2b29qaU9XcHhkWHVNVlpackMwVHBHeVROeWlBa0dwUm01?=
 =?utf-8?B?Ym1CYnRVdjRoeGVydWdYUFBpRS8yZ2RtNWdVQTRQdGRWWWkzd3hoaVVrSHI2?=
 =?utf-8?B?RDN5RmJEMWlFWFRPdXVpTDJYdmNjUnhEV3JDWjZBODMvdFJYZmxzb2o4bTA5?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0080ca26-183a-47d6-3184-08dab33aa609
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4758.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 08:02:50.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/CPtEiJXQP9lgZLGGUyjwUFcyAWsSkwHFqjestKh83UhRfJKlHYRVPtHaH/iIE1TkUcJ0hfcaxILMm9IwiHhcpXLd4gcV35GdBPhsdZL8zxfpAQJMTjyccti9svnvVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.22 10:31, Nadav Amit wrote:
> On Oct 21, 2022, at 10:25 AM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
> 
>>
>> Ok,I will move it before the enqueue call.
>> But are you sure about this the reset?
>> vmballoon_reset(...) is called only from vmballoon_work(...) which does
>> the update ? what i am missing?
> 
> My bad. But when the module is unloaded, vmballoon_pop() is called.

Yes, i missed the unload -  i will just set it to zero there.


-- 
Regards,
Alexander Atanasov

