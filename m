Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D376942D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjBMK2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58C617CF4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676284039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3CE4eMa3FyiLCFaW2IEzgSX8SFgyrVdO0vnWlAIO6nA=;
        b=KtLqC/T6lblPbvys/TJAD2zGYAVz33AeFShPXhkFThIZgH6fUbcuwG42DDEQocxJYfk/cZ
        bvD+ESaAXhjXn3+fG8dn+8ga23VAoR/+QHXXUkrpQxEjLQd5O/O7B2jCRQ4rMjphgm90EF
        MFLLOZSMUWNXBaNvF0P7XBIDswOCbb0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-yr7U-x29PUugnTwny-zCow-1; Mon, 13 Feb 2023 05:27:17 -0500
X-MC-Unique: yr7U-x29PUugnTwny-zCow-1
Received: by mail-ej1-f69.google.com with SMTP id d14-20020a170906c20e00b00889f989d8deso7389786ejz.15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CE4eMa3FyiLCFaW2IEzgSX8SFgyrVdO0vnWlAIO6nA=;
        b=PjrWk57zRpitOyTpS+tRgWniviRVSrCSSqwu17SHic4xXgBlsyMuJADOS17hltHr7z
         F8f9asP94eQVDYR3U2PyCmcdSy8IXboehj9J3MHf6/IZufkBpKP4X2/JfcqWbrK+EOjj
         KXcfMIec/i8DigD00i0dkds/2U+9DvGSLNbDowLmIybYOJwdPAEp3AemufRdzdKSxE6c
         vCjGkvam6doALt7BONEOWJCWSMaBb6H/WxcNbtc2dGNbFmAoH034rBiDxrXZ9Mc6Ao7R
         ZdNWClJiu9GCwsoSJYbnQMasFxikqQej8lv6XSdl8LKIZrjQ2itQyQdeSHByF5tRsq13
         JIwA==
X-Gm-Message-State: AO0yUKXv8ipmX3hKeU9w0EyfHGjJtDe5t2dEvzrIExFRUqhWDg46pgxO
        1bnYE9K4rjG9Dyu73vq6Lw9oCvDRgaiVliULZQbv23i0/vtv4RRzFI2p8b11YNp+LOId3haXAP7
        Dn0nM5b2w+LvuK71Je/wxj+tt
X-Received: by 2002:a50:f68f:0:b0:4ac:bd71:c595 with SMTP id d15-20020a50f68f000000b004acbd71c595mr6052587edn.23.1676284036689;
        Mon, 13 Feb 2023 02:27:16 -0800 (PST)
X-Google-Smtp-Source: AK7set9QGHi+YsmDnD9yqlqMdgEAeBYm8x6qQMbITvCHZ+TrYaMAuKZ6VJkCEQkGSU7621PEz/lV3Q==
X-Received: by 2002:a50:f68f:0:b0:4ac:bd71:c595 with SMTP id d15-20020a50f68f000000b004acbd71c595mr6052581edn.23.1676284036572;
        Mon, 13 Feb 2023 02:27:16 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t18-20020a50c252000000b0049148f6461dsm6340025edf.65.2023.02.13.02.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:27:16 -0800 (PST)
Message-ID: <06020103-8bbb-c02f-f59a-b4cad88d9184@redhat.com>
Date:   Mon, 13 Feb 2023 11:27:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.2-5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the (hopefully) final platform-drivers-x86 fixes pull-req for 6.2.

This pull-req contains just 1 trivial change, a set of Intel vsec driver
Meteor Lake PCI id additions.

Regards,

Hans


The following changes since commit eecf2acd4a580e9364e5087daf0effca60a240b7:

  platform/x86: touchscreen_dmi: Add Chuwi Vi8 (CWI501) DMI match (2023-02-02 11:34:38 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.2-5

for you to fetch changes up to eb4b55f2f26fc8a7b7dc6f06f1de91480d53485b:

  platform/x86/intel/vsec: Add support for Meteor Lake (2023-02-06 14:40:47 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.2-5

Intel vsec driver Meteor Lake PCI ids addition.

The following is an automated git shortlog grouped by driver:

platform/x86/intel/vsec:
 -  Add support for Meteor Lake

----------------------------------------------------------------
Gayatri Kammela (1):
      platform/x86/intel/vsec: Add support for Meteor Lake

 drivers/platform/x86/intel/vsec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

