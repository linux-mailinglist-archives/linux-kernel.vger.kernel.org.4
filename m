Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2226E742328
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjF2JWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjF2JWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:22:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061482728
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688030564; x=1719566564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3NRSTjyOfKpve9/AW/hw08ffGhe9mZ/e6rJCV787WIs=;
  b=GnVg3zTyoA+occdTYE85WyYkY+JU2knch2Rgsj9JfoU/pcKIv/lmkIKM
   6EVNOy50cst5haCFul6xJ/8u8+xlLdXXCy0D6hpWF0qMl2Zijx75dRgmX
   sxVWTjLEyTRUkWFlJgbxDyCc3P2rJenjdvgaL65J5Q+r1ycAKk5ln0KMf
   QxVDq70Rv+LdZDfvVvVTen7fXlarhe38I8e8GHPd2FixWc2nvhknSeEk5
   +cc1pXD0pgnTNB2Uuq9MjHB47E0ZPFOtF75X9LlJIgKOFXq3SENwGT6Ec
   2x9fIhQCaUHrX0kaD/J2Nw54HycAJZ6w1qj9nLtsApd+ZhCEJz5erRDlz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360913466"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="360913466"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 02:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="782622678"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="782622678"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2023 02:22:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEnrM-000oP0-1N;
        Thu, 29 Jun 2023 12:22:40 +0300
Date:   Thu, 29 Jun 2023 12:22:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v1 1/1] kasan: Replace strreplace() with strchrnul()
Message-ID: <ZJ1NYFtTJ/9CZ0qU@smile.fi.intel.com>
References: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
 <CAG_fn=WjLDsnUPKFwF8XJiyqYP6M+Q9ZqUweRPzPT3dW0i_E+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=WjLDsnUPKFwF8XJiyqYP6M+Q9ZqUweRPzPT3dW0i_E+A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:39:26PM +0200, Alexander Potapenko wrote:
> On Wed, Jun 28, 2023 at 5:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> >                 /* Strip line number; without filename it's not very helpful. */
> > -               strreplace(token, ':', '\0');
> > +               p[strchrnul(token, ':') - token] = '\0';
> 
> Why not just
>    *(strchrnul(token, ':')) = '\0';
> ?

I don't like Pythonish style in the C. But if you insist, I can update it.

-- 
With Best Regards,
Andy Shevchenko


