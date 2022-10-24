Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9FB60B877
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiJXTq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiJXToE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:44:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CA7194219;
        Mon, 24 Oct 2022 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666635141; x=1698171141;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5z5J6hyo+xzhPJHRSqQ2l3yOfGRRo8+TjXETgVVrD8A=;
  b=CTreJ/NTlalPXaOM+VYIQ30+UirYB0cafgqkos+0j5oy3cgHWYw7LuOZ
   H46KTgzh4inW7Y4JY3enkMEmQ4/H1dlplhzmigdzxecUwDWqD/4ENtikS
   MwoRzhj3NtFCfUMVT/oxF71d3HPGerykryaksqMgcFQu2btBXj5aOtubb
   r3ZCCUugQ8xKTDDKAyn6oX7tNUDDmhZoOb/2OveaOVrnDCMEx1Q6+khI0
   ptZhdXud2mHLmsXw48XlobER/BC++TMPpW/sLVwCZb4bmjteJ3B+Hi932
   krtHztMHY9HLvk4quni6YmhdKxT/cHBkDkI8PeiJz+gE47LrRq+5qUkuz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393805616"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="393805616"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 11:11:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609286400"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="609286400"
Received: from emontau-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.52.221])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 11:11:11 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH 00/22] Fallback to native backlight
In-Reply-To: <78ad5d7b-4078-0b8e-f4aa-6c8113631359@daynix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
 <746e5cc6-516f-8f69-9d4b-8fe237de8fd6@redhat.com>
 <edec5950-cec8-b647-ccb1-ba48f9b3bbb0@daynix.com>
 <60672af8-05d2-113c-12b9-d635608be0dd@redhat.com>
 <ea69242c-0bc8-c7bb-9602-c7489bb69684@daynix.com>
 <7373e258-f7cc-4416-9b1c-c8c9dab59ada@daynix.com>
 <ae3497ed-b68d-c36a-6b6f-f7b9771d9238@redhat.com>
 <78ad5d7b-4078-0b8e-f4aa-6c8113631359@daynix.com>
Date:   Mon, 24 Oct 2022 21:11:08 +0300
Message-ID: <87o7u1drcz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> That aside, the first patch in this series can be applied without the 
> later patches so you may have a look at it. It's fine if you don't merge 
> it though since it does not fix really a pragmatic bug as its message says.

I think it's problematic because it needlessly ties i915 backlight
operation to existence of backlight devices that may not be related to
Intel GPU at all. The direction should be multiple supported backlight
devices, across GPUs and connectors, but only one per display.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
