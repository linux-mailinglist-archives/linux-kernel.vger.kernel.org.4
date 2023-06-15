Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9230C731AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbjFOODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344659AbjFOODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:03:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFA51FE8;
        Thu, 15 Jun 2023 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1686837760; x=1687442560; i=georgmueller@gmx.net;
 bh=iXLy0cXrEehKxf0tsrC//fveq+MM53eyH3CeZgX6K2U=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=CUrdfbixMn0FIOS9spWIoqykq5cS35aDnMBoEhbUkrdq2wbedpaIQL0MxaRiQiyKFk1pjw8
 NML6bLNpuVdovlxPH+76nvFeOtZywUVUe7jCi2oVWoPK91E4L2AnLgxAUQgIGckWQZIWv2FNX
 tyRC7vRZcbajQC8DVIWxGyutKb8nLR2wfLiFpdUlX+82WwsqVVXD4MLVKhD1zfCPovcVOyydx
 HAOEUWJZLW3guOdYPNy+7cr+8CDVhHGuenBvCCsEc30vdrHG4e5y8fDCHUVw3n0dsKqxW8A49
 CWZM8QCPNOI8W6xIUXDaQXwBbHZ+N3iZ7xudIUATiBYTxrWCBp/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.54.0.101] ([93.206.1.113]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1pv8Rl3Nq2-00zFzh; Thu, 15
 Jun 2023 16:02:39 +0200
Message-ID: <e42ada3c-f215-d5a5-f766-7f8aa1580667@gmx.net>
Date:   Thu, 15 Jun 2023 16:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] tools/perf: Fix to get declared file name from
 clang DWARF5
Content-Language: en-US
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        regressions@lists.linux.dev
References: <166731050151.2100653.8202870942871353491.stgit@devnote3>
 <166731052936.2100653.13380621874859467731.stgit@devnote3>
 <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
In-Reply-To: <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ktJkoSPE4EnqpzreQkqA3phFUsKqBpjSGlVvltL7n8kMHIHNn7i
 D7PV7JZ2oTpxSOjkbxJB8K28PhosPii+K/rz3gCxufy9X5dkkPC7pjLPAPhktXG0R/4/J7F
 GXAAXiVC7bKIYqe/s75aEKkZ+7IlEBUNgmRBfhsr3KHCQpcWjv7vZ3RjcbUvYRFN2TgyUfh
 NEMpjMlodlsfPWKrTaI8g==
UI-OutboundReport: notjunk:1;M01:P0:b3kHxBFFCTY=;a5HnLdNG4ub3LRU8oHkvMR+5cR/
 2k3s/H1JDMAiRfJR2tb+AWO74hyhYoMWEUApTLVeiF0qHZyro0DzJNvDViiY7uD/selPCkq/G
 oIDRdWR2qvxo4Bt3kRyWA50mMztbC27VMKhbc9M4RDdezadlbMB7NhrAuikdftcRAXhN166R2
 +xZp8kWY6ExxAz9arf3V270F/iqqS0JIqa1YUBzGNGGlQQDUEBWtV1jDhBf301esc2PGx1D0i
 eGuANWdCNCT6hMFGAuxt8k+CwNBSfwTa2SjKyzK4ZjBfMvZrzHOHDv5Rd28ZRkYMRHgu2Fkdl
 jH367TaL0kQStYUcTzwKUy3LtGcSF10FAm9kL/KtFQl1VRBcRB/GavHd1fNvxxd5ba/KP9SYF
 i6AGbiarLpePi7Zi8vk1V5ZuI0mesomAWaL9oTQ/RldFqAWnnxbWx9Z64fgvLPIPVyMJX++n8
 wPFOYy8oeGmQydlTkAEls5FKKYSq5yFHk6vii3374T97iHvFz6ODOMSqqCcYVDcyOGiKdImPV
 /bKiz2inDg+Q7NDPyJ84ujt5FuUJiLZd0ucSK+XweJa+QeWUi2qUOm0NNei+YkUPyF+DKMwPw
 JDUfinSWulLxAgFntxmbkIcSywAsw9shb7M5/EueasUacgI+aSqyuL7w5G1u8sXwvi0VHXY2R
 BBmKecl9Lk+98CncYGTM+HwxzS0xY51YMuGaPb+pfVacl+rmq/YF8EoyZvHH64uJALQbwv3+c
 pnqMOdknLFtIa7kUtrPPYKa6iRHvzEbKdzWWFuj0DAOr4PKYs6Zp0AVRhprVCFsE8GakkVnor
 3/PSYNG82dHCiWwB6Z+PV5uNVw54Nh6sle99VokidHKLEeMmMltL/tHAr47QA7i7zfCx/AMnn
 SXS/cJmEZDh5Tee5ApTLt90gRqP5WkOaxl4fq39BBO/K/YMaA3rw24tRTNsO4mKUzFN9tXnk1
 RUucXQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have found a solution for this bug and will post a patch later today.

Am 09.06.23 um 14:21 schrieb Georg M=C3=BCller:
>
> Am 01.11.22 um 14:48 schrieb Masami Hiramatsu (Google):
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Fix to get the declared file name even if it uses file index 0
>> in DWARF5, using custom die_get_decl_file() function.
>>
>
> this patch breaks perf probe on fedora 38.
>

The problem is that die_get_file_name() uses the wrong cu_die.

I was pointed to the solution by reading elfutils commit e1db5cdc9:

     dwarf_decl_file uses dwarf_attr_integrate to get the DW_AT_decl_file
     attribute. This means the attribute might come from a different DIE
     in a different CU. If so, we need to use the CU associated with the
     attribute, not the original DIE, to resolve the file name.

The correct cu_die has to be obtained via

     dwarf_attr_integrate(dw_die, DW_AT_decl_file, &attr_mem)

and then cu_die from the cu from attr_mem (dwarf_cu_die(attr_mem.cu, &cu_d=
ie, ...)
to obtain it) has to be used.

Best regards,
Georg
