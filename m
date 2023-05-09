Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B279D6FBC2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjEIAvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIAvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:51:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6FF4C02;
        Mon,  8 May 2023 17:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683593503; x=1715129503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aHvbnWtDWpjYKd+xoWbeYChlxEJai6bgi54+BgIawTs=;
  b=QQ0O82ZE9WAtcvGfBJVpd8kQaXh6LmLoaLpg0AaeBsRAffKZtmN1b9bt
   VzjvMAToXJw76waLM3qt8Cfx9CXsYYEhSZGmnB9uy0ApeXcpFT2CjTUWP
   uPmnr6gJMlTm/4mfQyT8bkM8/S1rzUjrOHTgDkFtJ2CNCizkHNmQ3bM55
   qBkievATMZ8pw3YUW4W+lJ5TYgCPieFoyD2MP3stTiVGK9dV9ELUA9zM8
   9kJptK8EuGD/TICz/5n83f8Jz5KFEU0166btsFLMkro/zFeg1+uBUs4to
   nZoAK4RAD5YUIu4UzGOao6L25jR6W/MKJVw86NbKbbO/2xjuYYXU3lBT/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="377879137"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="377879137"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="842901610"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="842901610"
Received: from ahdamali-mobl.amr.corp.intel.com (HELO [10.212.29.166]) ([10.212.29.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:51:42 -0700
Message-ID: <5652406b-1764-ee02-d76f-c2c7ab66d213@intel.com>
Date:   Mon, 8 May 2023 17:51:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-8-chang.seok.bae@intel.com> <ZFWLoOZZTnBrid+7@gmail.com>
 <1b2eb485-2320-b33b-a0ac-53f7cb170adc@intel.com>
 <8748511c-cf9a-f3ce-e560-d0646dc3d108@intel.com>
 <e9508862-1fdb-d27f-8138-3b7691671405@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <e9508862-1fdb-d27f-8138-3b7691671405@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 17:31, Chang S. Bae wrote:
>> With the macro, they'll get no type warning.  The inline actually makes
>> it easier to find bugs because folks will get _some_ type checking no
>> matter how they compile the code.
> 
> Ah, when the prototype with one or more arguments, 'static inline'
> allows the check. Then it is not an 'either-way' thing.
> 
> Looking at the x86 code, there are some seemingly related:
> 
> $ git grep "do { } while (0)" arch/x86 | grep -v "()"
...

Right.  It's not a hard and fast rule.  We certainly take code either
way and there can be real reasons to do it one way versus the other.
