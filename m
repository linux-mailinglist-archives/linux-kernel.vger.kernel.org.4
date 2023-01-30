Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3888E681943
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjA3SfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjA3SfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:35:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38041134;
        Mon, 30 Jan 2023 10:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675103710; x=1706639710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U7G2OF6NcSz+fRV4Opwe5468B/UHNZt27GJPYnCXJCo=;
  b=U+9KpDXMvGS5+UTAHXpYRyHLSrRqcECIwLUOy7DDrpDZvr/ra0ju0dDp
   jIXgNEd1OOrsMhrvhvba0pqrQu7TtCJoo6QMESy8sm6prh6mv2FkCxhc6
   pyFghR/V8GfkciBihKY7lzVQHpLj9Sp8doE8UHFkCsIP7ro/TuSi2OBEV
   uFr1wLsRSopUjU+xInUWS5Xc0sePTQKdTyvBONKmA8lHnSQ4P4NfC6vGA
   9rTpaSs3HcmuucMy/8+2jUGJ2FaRxbEgf6DhCgCV2NoZ1LgVRhfEU+VUD
   YVUr1LV0OFKIJ6hRpiTnou/MBtQ4ofHmOgOZ2VUPtiAkEo35SZLHXiv4b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390003698"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="390003698"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:35:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="806784851"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="806784851"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.33.106])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:35:07 -0800
Message-ID: <5aeab2b5-7349-d220-652b-75360ef6d723@intel.com>
Date:   Mon, 30 Jan 2023 20:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 2/9] perf symbols: Add support for x86 .plt.sec
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230127170222.9895-1-adrian.hunter@intel.com>
 <20230127170222.9895-3-adrian.hunter@intel.com>
 <CAM9d7chny89+rtP6orSJOKrAqb4GbzCG53KV4O1J9mhKvCcWnQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7chny89+rtP6orSJOKrAqb4GbzCG53KV4O1J9mhKvCcWnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URI_NOVOWEL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/23 19:34, Namhyung Kim wrote:
> Hi Adrian,
> 
> On Fri, Jan 27, 2023 at 9:02 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> The section .plt.sec was originally added for MPX and was first called
>> .plt.bnd. While MPX has been deprecated, .plt.sec is now also used for IBT.
>> On x86_64, IBT seems to be enabled by default, but can be switched off
>> using gcc option -fcf-protection=none. On 32-bit, option -z ibt will
>> enable IBT.
>>
>> With .plt.sec, calls are made into .plt.sec instead of .plt, so it
>> makes more sense to put the symbols there instead of .plt. A notable
>> difference is that .plt.sec does not have a header entry.
>>
>> For x86, when synthesizing symbols for plt, use offset and entry size of
>> .plt.sec instead of .plt when there is a .plt.sec section.
>>
>> Example on Ubuntu 22.04 gcc 11.3:
>>
>>   Before:
>>
>>     $ cat tstpltlib.c
>>     void fn1(void) {}
>>     void fn2(void) {}
>>     void fn3(void) {}
>>     void fn4(void) {}
>>     $ cat tstplt.c
>>     void fn1(void);
>>     void fn2(void);
>>     void fn3(void);
>>     void fn4(void);
>>
>>     int main()
>>     {
>>             fn4();
>>             fn1();
>>             fn2();
>>             fn3();
>>             return 0;
>>     }
>>     $ gcc --version
>>     gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
>>     Copyright (C) 2021 Free Software Foundation, Inc.
>>     This is free software; see the source for copying conditions.  There is NO
>>     warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>     $ gcc -Wall -Wextra -shared -o libtstpltlib.so tstpltlib.c
>>     $ gcc -Wall -Wextra -o tstplt tstplt.c -L . -ltstpltlib -Wl,-rpath=$(pwd)
>>     $ readelf -SW tstplt | grep 'plt\|Name'
>>       [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>>       [11] .rela.plt         RELA            0000000000000698 000698 000060 18  AI  6  24  8
>>       [13] .plt              PROGBITS        0000000000001020 001020 000050 10  AX  0   0 16
>>       [14] .plt.got          PROGBITS        0000000000001070 001070 000010 10  AX  0   0 16
>>       [15] .plt.sec          PROGBITS        0000000000001080 001080 000040 10  AX  0   0 16
> 
> On my machine, it's not enabled by default.  And it doesn't create .plt.sec
> even if I pass -fcf-protection=full option.
> 
> $ gcc --version
> gcc (Debian 12.2.0-10) 12.2.0
> Copyright (C) 2022 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> $ gcc -Wall -Wextra -shared -fcf-protection=full -o libtstplt.so tstpltlib.c
> $ gcc -Wall -Wextra -fcf-protection=full -o tstplt tstplt.c -L.
> -ltstpltlib -Wl,-rpath,$(pwd)
> $ readelf -SW tstplt | grep 'plt\|Name'
>    [Nr] Name              Type            Address          Off    Size
>   ES Flg Lk Inf Al
>    [11] .rela.plt         RELA            0000000000000688 000688
> 000060 18  AI  6  24  8
>    [13] .plt              PROGBITS        0000000000001020 001020
> 000050 10  AX  0   0 16
>    [14] .plt.got          PROGBITS        0000000000001070 001070
> 000008 08  AX  0   0  8
>    [24] .got.plt          PROGBITS        0000000000003fe8 002fe8
> 000038 08  WA  0   0  8

That is interesting.  What does it say with -v i.e.

	gcc -v -Wall -Wextra -o tstplt tstplt.c -L . -ltstpltlib -Wl,-rpath=$(pwd)

And what is the distribution?


