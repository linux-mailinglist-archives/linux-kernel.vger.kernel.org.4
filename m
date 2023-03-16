Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC36BD8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCPTMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCPTMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:12:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88321F5FD;
        Thu, 16 Mar 2023 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678993963; x=1710529963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=isSa6T4VpH1WCIHZYBJ+SROq9MEvWMv6WPoU3Z3MMMg=;
  b=Q4npJxBxVkXRhXANBm+BqXtnii8eKmJiWPgVGX9hXvypHzpw33TnMT0p
   B0Xc2SaMhR+blPPg2mz4d47Ls+8I72uM/EywIJJpACt6XsHSSyN6KcbVl
   kc1LtlahasZ5GUklOwxG32nwU0dLxU4jP/YBsvyFetLDEdjPw7oY4aaZ4
   HQWvuSRFElylM82qjnMtnJnXwOgspOnjWmXCj1S6aN2O+fouEm65edUhQ
   LHEjFk8bP4ZB7Ay9/wLgnCfy6Mdeu7e2+j0DMGuKjIs5R2wJTd5Sgjv9J
   AusdB3DilG7K39SFSKkvw/UsbM9IAhkhkOG7Dt8/6LiMiKERSKusBru+L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="317743429"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="317743429"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="769073124"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="769073124"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.172])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:12:40 -0700
Message-ID: <522a5d01-e939-278a-3354-1bbfb1bd6557@intel.com>
Date:   Thu, 16 Mar 2023 21:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports an
 internal cache
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
References: <20230316164514.1615169-1-ulf.hansson@linaro.org>
 <ZBNIg8+rOdFKcsS8@infradead.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZBNIg8+rOdFKcsS8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/23 18:49, Christoph Hellwig wrote:
> On Thu, Mar 16, 2023 at 05:45:14PM +0100, Ulf Hansson wrote:
>> File systems typically uses REQ_FUA for writing their meta-data and other
>> important information. Ideally it should provide an increased protection
>> against data-corruption, during sudden power-failures. This said, file
>> systems have other ways to handle sudden power-failures too, like using
>> checksums to detect partly-written data, for example.
> 
> Sorry, but this is completely wrong and dangerous, if not intentionally
> misleading bullshit.

There is some context missing.

Historically file systems have assumed that sectors are updated
atomically i.e. there is never a sector with a mixture of
old and new data. The eMMC spec does not guarantee that,
except for the eMMC "reliable write" operation. So the paragraph
above is informing the potential benefit of reliable write instead
of cache flush.

Note, it is not that eMMC cannot avoid torn sectors, it is that
the specification does not mandate that they do.

However, the issue has been raised that reliable write is not
needed to provide sufficient assurance of data integrity, and that
in fact, cache flush can be used instead and perform better.

This patch adds a card quirk MMC_QUIRK_AVOID_REL_WRITE
that can be set for cards where cache flush outperforms
reliable write.  We would expect acks from someone in the
manufacturer's organization on patches setting the quirk, effectively
assuring fitness-for-purpose, and implying that torn sectors are
not especially more likely than any other sort of data integrity
failure.

> 
> The only way to provide data integrity is to ensure data is written to
> the media and not a cache.  That can be done by a full blown cache
> flush, or with a FUA-like optimization.

The patch is just reporting (via blk_queue_write_cache())
that FUA is not supported, so a flush will be done instead.

