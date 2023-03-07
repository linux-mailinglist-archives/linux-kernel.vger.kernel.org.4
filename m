Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC566AD490
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCGCVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCGCVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:21:19 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2117.outbound.protection.outlook.com [40.107.11.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719576546E;
        Mon,  6 Mar 2023 18:20:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOketxlZtpXHpvlNl+zfmeDANmEqpozJPES8LxXyGTv+Ay5Ip4Hjt2AR3r918CTmuMqRFsGn8wdlGHNPrA5uiQ3v9oxSmxu0kn/KmOC33vp3ug53nHhCY9wAPerWC92MzYju4DXe5+6bTw8VScjMXlEj7+yRMVZWvu098Md1Ggf6xJ0GLMOrQNZpGNJKKrU/oy23AjU0uwOU/QBmnogg/LKHvcOoxgmANHmZZ0dOH9kAz94VPcCn+x0z2R/gitqNTY/kJncQecXf4WUMNuqpwjnwWgvKG1ce5/tfkVYfkc6jx1Y81NnamQ1gnHowhxWcE4fZxxFFjBeoLj3JbhekyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9kyDDGk+WjooeEf9wvB+S9vY2ybLe/VzhMuFPYi7mQ=;
 b=CCw70RXjfnW7CTpmka+qXnQA3+p9E3luxVUhnk6GJJdV0ytPW2AmL4O+hArDveVrMVimVyak5cEjlXnFysMUpf/bm8TsFJXcfvMa545wuCFbw5RekcUTzy9UuR8xfpvLbYBESNr8R3FTPHKpDBF4PI/uWhJ0/ITMvp29qPe0WRtr9hiL5/1aQS+jsFLHl74vMFM3FZaiScqP8vLSj6uPz554Ixn30kWMgmX5qvZ1WBGy7POcYh4QPYVdt19pZOoZmPeLh59yf4f7H1u7vLY2nNJT2dJ32xha1eNqKM/wrrpYpwWP7DMSnbfB/AjfY3eDpFBB9ThxLm8iqlf0Bb6o9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9kyDDGk+WjooeEf9wvB+S9vY2ybLe/VzhMuFPYi7mQ=;
 b=0HijC8az3QnJkBnMblysGH28ExVvwziQyRGfSRU/5f8bGF8CVQhWnK2xDEnCtZPoecC9bsAzUteeGcLx7oHLNEmgKAckUWOxSpLv5cB5RqzrgaJh+KeM1rMrGQvdG7Oaeu9hKSBWr71xLsIeZBcq74xV+s3rTo+x9Jj41+rMZ/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB5968.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 02:20:43 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 02:20:43 +0000
Date:   Tue, 7 Mar 2023 02:20:37 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, bjorn3_gh@protonmail.com, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC 0/2] RISC-V: enable rust
Message-ID: <20230307022037.6528b6d1.gary@garyguo.net>
In-Reply-To: <CANiq72=hvS6KxxkLocFOrU4E4pNi=y4OuJLm3iSiPGmi5B178Q@mail.gmail.com>
References: <CANiq72ndkF0JM1kV=ewnO4uGirDowHDGLkhvjQgtLnuPEk_hTQ@mail.gmail.com>
        <mhng-a7ada57e-543c-434b-a4f3-4fbda9238eb0@palmer-ri-x1c9a>
        <CANiq72=hvS6KxxkLocFOrU4E4pNi=y4OuJLm3iSiPGmi5B178Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 46755232-f709-4f61-f0d3-08db1eb28d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xioVLPyEpLqfMucbQKjAb4ufDM3OM8Bz6A97AUORbZFirRV4CZLxgIdpQtvhmYClTr2hdta2OP4ZdK1suANdwnetQ1lpO+8AolZkRKtyCCDxNLYWPs5H31VSku6XRHxIHyiFQ3+j+ls3iWZ/FD0BRhLwvRkm8aRJtvr7kRWdz/go42sUKlT+NTpH4iV14Jhh9scF4dy24uWJCU3LHCBcrEeGKIpQYkAIIRfcXzfysx8o34J+YCAPntAORe4ErBJonP4GBiTs0hE9dmrS9aL9z+n4dXxDqRWXkEdvNXKz9gKF1Jsp5uKbM4PYAItknwKchZQ4xEjkpEpmzbtmWs9DxP7n81D2+nsKSx6gCXXqRcjwbCC3ddEtCPBZYKZn4HucvbpJYgdCxgRMfAWBuVgB286Of6W0D47cONiIKEYxt/7mCR5UOWKcJfDCI9FAB8ZLU1t16VmPX+4LVb0OYNbEe7IGP7SeaTRJ2o65YRRHnJp9hYXH/mp5WVcXyceSdKTzL/2FnyXS6ewX39Bt0aXp/EyApoXZeH8p8Ph6F0tv7iaCPgbDWobZTJEXjr6zZ1YUHk87T4vLrpQsNXg/qQ5VK8fniih+NtmTFMZiWOVcnjLV5yS1mHVuUK+YmHTyuBmlEyggn9swS3b6uUQd4C1+7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(376002)(39830400003)(346002)(451199018)(38100700002)(86362001)(36756003)(5660300002)(6512007)(4744005)(2906002)(7416002)(4326008)(6916009)(8676002)(8936002)(66476007)(66556008)(41300700001)(66946007)(6666004)(186003)(2616005)(53546011)(26005)(316002)(478600001)(6506007)(1076003)(6486002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZXYlZTTUowUW9RQkV2bThGZkxqcWt3OVFOZGJJL2pCY0JJTVdXbktVcWtD?=
 =?utf-8?B?VmZId0xjT2FJeVZPTG5IVVA2SFBBMytwTjRkNFgvQlE3TEhHS2xyMjZOUjRH?=
 =?utf-8?B?VVRaZzM5RVRCaTBRRHkzNnhON0c5aWJwaFRSekdpOWFaTGJoTXVjL205Mk1z?=
 =?utf-8?B?ZUVHd1RnSWtHMDNSd2tIL2pENmFZTnFNUXl4M2c0TVZSMm9wWW1TeVdHRWNO?=
 =?utf-8?B?OFBUNytGV00xOTdvWEV6RWhRTHBDUS8vTlZ2VExZcU1nWUMwZkxNWmt4S3lk?=
 =?utf-8?B?YnV3TzFaV2svRStnZXNGanFKNXZ1ODl3Q2tKSHNzTFNOclZldi82cnppMzE4?=
 =?utf-8?B?TkFiTHdqVlRVcWl5SGJsUjZGak9uV0VLUFNScENyMzlYOGlUays2dG0wTS9j?=
 =?utf-8?B?bUh4dldHSG9PanRPYUUzUkg2UDFaMWZxUWxSZjZKajZNRWxJcFFFWWJZUFBl?=
 =?utf-8?B?QnhWU2gybFFrQlJrWkMrTHZVY3o3L1lxK3JiWno2am5QR0MyeUI4eWpYVjYx?=
 =?utf-8?B?aWdiNk02d0RlR0I1ald1VDBuS3d5eE1ZVTJzNzBDNlVzdC9BejFtZUNUS2tS?=
 =?utf-8?B?aDM3WlhGMmlrNmEzY1Q4cXA5YWpta3lwUzhVYWVrSmFON2dGbys2NTR4Ui84?=
 =?utf-8?B?cXNzdUVVQWpzTnd6c3g2cUJVNnY4RGhvQXQ1eUVYaTVLY2pTdFZESGExOU9T?=
 =?utf-8?B?MzNSZ0JNOUxyM0dhbWU3US8rbkd4bStVTmt0VTNURHhYaW5LNm92T0RPU2t6?=
 =?utf-8?B?SlZLK3FEQ3VZNU83eVlhbE9Pa2tpYytiamM4UlJYZnJkYlRDSkVsNnhHNmRQ?=
 =?utf-8?B?dnJPNTlia0JidnE2TmZnWDBNSnNJMjhDMThwL2lHSHZhSVRieU9rSmJtY3NY?=
 =?utf-8?B?MjdkeklGK0VSYkhyY0xkVEprYjZ1QmE2MTUvTnprN2Erb2lwZnN0UjZRTUh2?=
 =?utf-8?B?UE5uOHVxeTFiRVZML1psUGc3QWR3dXFkTFRhTWRvTW5KeVdScDRHeUVaTUY5?=
 =?utf-8?B?SkNSV3g0ZjNWb1dnVGhYWUZlbTBySTNXQ1cwcVh5ejFRdk9lemdLM2hJTlhv?=
 =?utf-8?B?OEtvMWpWaVBjeVBqcTl3bTZMRXg0WWphTS9SUWszcWV3anhEQm5FKy9uWVdn?=
 =?utf-8?B?NWpsL2NUanZVL0Fhb2pqQjMrTlV1OGhFT2owQkxOWUJUSnkwZW82MlVLZUE0?=
 =?utf-8?B?RVY2aFE1SGVocFk3emlUOVhiQXpjZzFJWDdXL3VSdnRNR1J5N1FpWm9sdkNx?=
 =?utf-8?B?QmJIWTlMRUdDWmNDYjZUODZWVnJkUVhPOG1RSFl4VXhKNXUzbHFNWFl3UjVo?=
 =?utf-8?B?OGN3K2UxUUFvZk9GNGVKbGt5NTJCMmw5V0VXTVFIckdUVS96bFpyWWRlQ2hS?=
 =?utf-8?B?cmpwbnl4TE9uM3JZbmFnVTgyY3FjMDlONE5paUpZNVdEUjRldGVGK1dncm9v?=
 =?utf-8?B?VVJ3T2FncHZrVmx4dmFvcjc0VDVxZWVQRUhHYkR6SDVtMjVJZWxLVmVLMEs0?=
 =?utf-8?B?ZkxMZUZzekQvdE5ndmdEN0EyVmdEcHphMkptOUZ6L0UwcEpUcnFGUmRsQnRV?=
 =?utf-8?B?dGU3QTUrdVJ6OExYZTZHODdzVjZFYURlYjBxT0RZcFh5OHZGSGFnNG9rRjRV?=
 =?utf-8?B?UHBaa2J1Zk03SG1KQmVINjEzRjFXcjdwODUxL0dkcWFFNXYyQm1LUGNOcVF4?=
 =?utf-8?B?Q2lnODBNVDhsL3Z3MHJRbko1Ui9lM0hMa3ZkWjNJS1RqbjdCdG9zTkdFUXcv?=
 =?utf-8?B?eFptUEhaeXJzeWFZYlp1aUZBL0g5aWU2SmZuOWxFQjAwdCtJQm5DNTlIdWdQ?=
 =?utf-8?B?WmxwcjBoNkF1TlNSdWQ1dVlydll3RTVmQ0ZTUDNJNzBLYmpmaGR1VUdSUTM1?=
 =?utf-8?B?ZkJZUG9kL1BoZTNLWmNMR09vREVtYkpJTDRtWlJTK3BwaXZSWHlxWWpZTVFk?=
 =?utf-8?B?aGlJN0NiVG02WVNEdWZlZGh3OEU3RGxkZTJXbVdQZVlsNHRvc2JRRi9WNHM5?=
 =?utf-8?B?ZGlQRXFZWXpPZkpyb1ZnRzJsc2s1STI2YVMzb0UxSXlxOW5acVlBWnJCNmxj?=
 =?utf-8?B?ODQ5OFk3MndwaCtRVjN6MUFjOVBYaGtSNVE3WnFhSTNZQXRKbXMvaVRRdVR1?=
 =?utf-8?Q?+hYaVYJBNGtYobkKOxczIyLza?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 46755232-f709-4f61-f0d3-08db1eb28d91
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 02:20:43.2939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfkXZvK9e/I4bkzYoUuMSVIIJkpFlo3fQGSxNcKOzrJQI4IVky241Y/Zm+WmN8DnCYhg78xJoi0hH+e/5RuCbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB5968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 20:28:47 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Mon, Mar 6, 2023 at 8:18=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
> >
> > It's time for the next release.  IIUC there were some authorship issues
> > here, did you guys want to re-spin this with those sorted out?  I can
> > give it a shot if you want, but I'm probably as likely to screw it up a=
s
> > anyone else... =20
>=20
> No problem on my side, and either way is fine! Thanks!
>=20
> I think what is important is that Gary is aware and agrees.
>=20
> Gary: do you prefer to be the main author or the `Co-developed-by` author=
 here?

Co-developed-by is fine.

Best,
Gary
