Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC653704384
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjEPCk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPCk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:40:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2046.outbound.protection.outlook.com [40.92.41.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5BB8;
        Mon, 15 May 2023 19:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqLdlVuA0toNvLds43KC52RV1w+8KWEYI5ixeU/ExzQYIlXqldTNpMnQZYKKlefCAu3nFa9bgQOG/i8Au9QZ9oWqbnyFWFQlYM8X0Kmy0EnZS+fcEsU8MLtA5O7YAL45ymxo2qoiRcXsdNnMtT/q231JtQVaPQejqP1m3gz2qbwe/qRcVB11lxKPCMJ0DW4UsZZnFOEG1vVYnFSdaLn3JM6a0KJ7ObE1bSkHz6Rb9r14Y1bO7JJ4VbH+8SymwfMq+ih7T+eCJ12mVLtxL2gVUhGZgiTMorQqcqFJheZSk49zKJICVsIjFWdcNofKEcDfDGy2QEYo2NvFjmuZoP7MWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVdn2hoq0Uoz7op4rBq+OHEi4HPGI2kron5FIErOyy8=;
 b=gaBVWnsKK5VAdszMCxfeYAT1YmUdY49RA+19YMK3+G+nUEROSPz3vtwtlRkhom4Ti4Fpx8pjUR+C0ICTvBR2Amth+fQ5x4ZwgGBfgsva7teNF0TNkwQDOVL/jnLMzhUZ0Hck3oZv9uuCJ/NQVmFS6JOAFVu1g/aZxwI4VsMJkpbqUbFEEh+1DgSAozIe8FeeOhVEnZhXet8MTa0qAqzBvganM90tBZIHvEGQ0mzHdsVTM2BbMAAG0WEyqyX6WIdqaRSEkaszMLzefi+wgUxnnpgaF6sNrq7vLOcSWEIuxx8Qs8ktFxk39sio5OR0XOunVl7oVlqsJgLWswnNmxC1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVdn2hoq0Uoz7op4rBq+OHEi4HPGI2kron5FIErOyy8=;
 b=PdriM71R4Uy4A89kY5jRQY2fElv5nYJu0xZ4u6IyP5jBfheuu2uaprAFN1RRHj2T1YUSwhyR7edhGbKE5PNX6SHyQ3xpRO5Ytd3Jb3kj7ex2zsBd+umhl+jmT3aA5DBSpB+hy5D8XCaVGA+s+6hKqG5xG+YgYzHZSOCodl1E0K5qmSG0FdUXku3X5wCeCqFqjy4x/0hN035yzqRS8/TEywvNHGX/LYE1i+9A2ysia68PNm1UVu+b9ULnjMrWnAGzDZxMph95+0t440GLOsWqmvzqd/FUci3cbKV/9EL3pPwY/VfNGrLRYR4Psi7kUG4I6o874omFbYm4Jkrylkwe9A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB4457.namprd20.prod.outlook.com (2603:10b6:510:13d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 02:40:53 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Tue, 16 May 2023
 02:40:52 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>
Subject: [PATCH 0/2] perf: add T-HEAD C9xx series cpu support
Date:   Tue, 16 May 2023 10:37:12 +0800
Message-ID: <IA1PR20MB49539201E93DE46A9A2A8E74BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [o7cot8Dg0enCOjpgotPmJWqxekM7KDpBbXMLw5hv+u4=]
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230516023714.306240-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 68737826-cb09-438c-6a6b-08db55b6f72a
X-MS-Exchange-SLBlob-MailProps: mWtqiNqNgRuKO27nt/mZoWqn7+cej2Mk2sWuZ35QmaOBDLAh++ZXCHYw7tg9TcuIPJ3K/Pn8sV8sCEUbEUak6rcV5ncjGh6e+MU+SowpzSohXZM1gSIXNZ9PlBiYKgK+VFY0EOZYKTdqN8IB+MFbWPwHjyomOQ63LvSIb/LsbUR1Jd97PJsTO30Io3+WvDSoAqUMlJr7eMFoF/Iafg8/3v3KjwmyHuBLG+V/5no4abj+Ymnb1+wiWaEoCJ9nwnT6gujb5sjuOuLakiEy6XhbRpoBhYQWs9hA3zrQeYRsFevydREE9fVt2csfbq1sDZCjHSRIspa6Cw7jfPJkwfJnj9C6hCNnsbC/uv0vNq6pPq3WDEVX9h7LVQceTtTByOD0ZR3Lo9aR8QCHtDoDClOOks/fW/KYDB8AWNNOG9sf7URpxJCmENGvBzzndXoAskqpziwX4D83vVaoJGYJ2NFrAqetbUHV1N+N5a76QbNDJjN3ggy5y0cqciI12melYXzdOoyUxDvxIAQGG48uwBctZUqWh71JdjOaMtzqAbSWIHnwP47+T6cnJaoYYRW1epJm+OIf+3f+Eh0hDMyokZIVrYDxnw48orT9vxl/Skn6b4oph0zk7HObvsi+MOGtw9oG+l32XBiEb+1NYAgSUNVff71Z4jRWgw0RsrNVokV24J4t0lfAuVEnX0gQYix6Pv7G4gCOOeGVhpOpudFEqmkMXgWynAlZZ2xK7OPM7uKNG9iPaYcg/gCbQMsZFMZ4fIqJe3k/e51yVUSvCvNcc/ccbPRbJuWZN0ZHcB8XDirhlV8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHOLTdQvGxLvDWkdXsQzqnUFzHHxxHbgh8Bmxso4GN9nKnJFWWAKTuKPOjRi39Fgrcq1+URwsQlkOCJZKiFZqSXiL5RmBTKzmfmfnoXo1CqqpYe0bmpAW/av5G71hnE3Wg4hiLBCaaJ7HiMvY8vAZOU9hXbOdTAnfgJkJoX1SZyWKj7KQ2dTFw1uO6rUV65xJuk3oie+UC4ClXgqz500uDu2EYr6u0Kv+cCbyoDIhTbERQrrxlfVm0e+vXHR35e/WRk3OuDGpKExkI9ht1HMS5OUMGQ6bIeTiRx58r5/ZmDjW7FbM5BOKBaUAKHRCKYn7Ohq4WR3ho4bp38CbNRUTnAsZhtqT8c4epRfSnxKAgpAdaY+s00XWCs3mHeVorq3OoRIZalYPRbs7eIuNRn+D7WSly89HRB8cdQXSYvXC8iNoryOtMV8Yu/k37Rs+TeGH0kyejDVf6g9gO2hCZwdI8/ZA+cunZdtTdL6xs9HrLdxT3kG69mYs+x2GcotPKjcX3uodgOWFtnVlFNiJ0m3NavyuFkuNsD1U1tkgcJdWfrMscdB5YsIEkw98Kh48PTXBUp6ldlYzYbccIVR3j5HhUiVWRBy/FOIDa+03qS13nA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8YICoQxmOYfgObk2GEFVzY6QhjoEIPFyKXhZrG3ln47vlOyIlEU2X5sflN/?=
 =?us-ascii?Q?ImPzXb4oP4ESYMOQfFNsyt+Wt9fnb9L3Ichuf6x5685VPf/OHOE5ULQrNF6K?=
 =?us-ascii?Q?q8SFFdaG/i4tUXef1lRuAKndh3Ep1rcEcfXhkfY9oCvnxvhEelQ6+871QFN+?=
 =?us-ascii?Q?QD10GOEwJD+bY+dRtXMYo5Wj+9TpISAqKUPhuTUhEsjQ6sEN2fZKRgdyYnBy?=
 =?us-ascii?Q?gUNB19N5uX4WXQkFiVWRhhfNkraHG9LtHDKTT+BvLQTUgS76guNhFnAEe8ks?=
 =?us-ascii?Q?XJvVuARxh99mjP735DIrOUdsO3G8BHYPcWH8pL9wqo8tzxkN7n6PoIjnFcJg?=
 =?us-ascii?Q?GOeJUTHmV8vKuKcGqoOftf6cqO5wMU4Fa5P4K8pT4XoItDPNrGF7jroVvdqB?=
 =?us-ascii?Q?4Vupvepxe/NqvfvoqvnQu0MZrKIsdpgCQhVRrz9yYgE2xIbtFOI+DnxggHrG?=
 =?us-ascii?Q?UAEBRDf+5JRLgDsp8hbJL6EtiMVNWqmeMhTHsSuy2UJCNfxnqTlouAYHrcEG?=
 =?us-ascii?Q?0qlOE0GR7oPMA0dF3cagOprlvcBpx0PWefa2GUGGbdp+zKxKbYrz/keNBte6?=
 =?us-ascii?Q?ze69OvRJ2BW6/g+jkCUJ+OJIDY9yzQc/LbvdZVZz1kNQ/dXQA/+VzQIv+/zL?=
 =?us-ascii?Q?c3iq5U2mCv/y9PrxbZBRGSl4l9o1dSXXRuzWllT5KirFvieRlZbEdhfvjfWv?=
 =?us-ascii?Q?XbMenbQwQQAjucAo48c5PrV9w/m/SBZr0Ij034y48nput3ZaxVO5Vpsba969?=
 =?us-ascii?Q?kdiXLiAmwTt+ac3YL6cyRYqLbqJmPwMjA4Dl4EJpbVWK+iSCn6MTuAO9JrzH?=
 =?us-ascii?Q?Vy/TAE7AeAfI9Fp+/891YdIAljuBTGvKTqAFCltdXQxaaewN29zigRn9wLi/?=
 =?us-ascii?Q?RCixhxbNHQ0ssmamHFiMnPyLqMewANUk5ak5bi+zmtlssMIO6yhA282YqKZa?=
 =?us-ascii?Q?N3tF72aMbNTnBJ5WoQZWL3zcdXJ7HV/qITmqfx7YQ0OyVzZxeI8WQir3ySEe?=
 =?us-ascii?Q?0W5BRCU4aCjiz9xqMqYmPtSDO3zOM9CUQ5dcDYjXE8GSSHg7iew9B0SH4rfU?=
 =?us-ascii?Q?zr92kWpoAULiD6CR8M6c7xUIIzaUhmV++pldAzs4FsLd8/GarLG1/b/h4xsw?=
 =?us-ascii?Q?KN6/Ysu8nOo5dG5z5sICqH1r21/0ccRvVxL3pgqdfrZ/YyVqFNRJF/s+NyUK?=
 =?us-ascii?Q?jogo8uS/dnd/tlLmCu4xZmYZhE2AteoAKPGnMP7vmv7IB7FxyQJ6r0/6mVk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68737826-cb09-438c-6a6b-08db55b6f72a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 02:40:52.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4457
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T-HEAD C9xx series cpu is a series of riscv CPU IP. As this IP was
proposed before the current riscv event standard. It has a non-standard
events encoding for perf events and unimplemented MARCH and MIMP CSR.
This patch add these events to support C9xx cpus.

AFAIK, at least the following chips used C9xx cpu.

* Allwinner D1 (C906)
* T-HEAD th1520 (C910)
* Sophgo mango (C920)

Inochi Amaoto (2):
  perf tools riscv: Allow get_cpuid return empty MARCH and MIMP
  perf vendor events riscv: add T-HEAD C9xx JSON file

 tools/perf/arch/riscv/util/header.c           |  7 +-
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../arch/riscv/t-head/c9xx/cache.json         | 67 ++++++++++++++++++
 .../arch/riscv/t-head/c9xx/firmware.json      | 68 +++++++++++++++++++
 .../arch/riscv/t-head/c9xx/instruction.json   | 22 ++++++
 .../arch/riscv/t-head/c9xx/microarch.json     | 42 ++++++++++++
 6 files changed, 201 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json

--
2.40.1

