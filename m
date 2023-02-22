Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0822469EBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBVARt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBVARq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:17:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A341D305E0;
        Tue, 21 Feb 2023 16:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:From:Cc:References:To:
        Subject:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pzQDfru4JJCoWsO/XRCjYdUO9SXR3dHdbLemp64mhMg=; b=XqLPUz2cO5NB0IYb7FfQMthzoV
        o645DAi2siHrTkqLygSJg2I5l0RTiy185asUtBO3D/h+PqeYFQSJXbxCHgNgoUj7quH0Q2I1Qy5ii
        IPySQkxwBcDNA0ZiC8+ifr1iJriKf4Oyw4ddCK3ILTxVvPKLKGKG2wpRwj4rYe29dEVm5gevOq6uH
        HciC9+ueDT48dmW8E/ROVpYOTbN7viqwXvHQDeIUiCUeaRuzASOXGOoFtrsbb6jZaJXzfMGTPVI/d
        3CR/v0shuP6SFqEqx31pDbKyujVuFsoKQcOIZpJKCeQ7+jc70p8kvOXq7B/sAfOmv16HPPp7VBO4W
        X6nNAg6g==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUcpM-00ADRp-6i; Wed, 22 Feb 2023 00:17:44 +0000
Content-Type: multipart/mixed; boundary="------------Mgy6DUrtLwqyLcxdknj6b30y"
Message-ID: <1c1c0a3b-10d0-ef9c-e96c-a415bbe0bf33@infradead.org>
Date:   Tue, 21 Feb 2023 16:17:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: .config and "make" / turning off all debug
Content-Language: en-US
To:     Hanasaki Jiji <hanasaki@gmail.com>,
        LIST - Linux Kernel <linux-kernel@vger.kernel.org>
References: <CAMr-kF1LxzoOShd7nkE1Pc0ZZgTusB42rDep5ROPirLK9xK55g@mail.gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMr-kF1LxzoOShd7nkE1Pc0ZZgTusB42rDep5ROPirLK9xK55g@mail.gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Mgy6DUrtLwqyLcxdknj6b30y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/21/23 08:16, Hanasaki Jiji wrote:
> Is there a command line parameter to Make that will disable anything
> that results in a debuggable kernel?

No.

> Is there a tool that will modify .config removing anything that will
> result in a debuggable kernel?

We don't have a nice, clean, packaged way to do this.

It also depends on what you mean by DEBUG. I would first disable
CONFIG_COMPILE_TEST, then decide if you want TRACE/TRACING features
disabled or enabled.  Also decide whether you want DEBUGFS
options enabled or disabled.

There are a couple of things that you can try. YMMV.

Neither of these is a complete solution; option 2 requires
the user to update the list of config options that should be disabled
as needed.

(1) Use a script to convert all occurrences of
/CONFIG.*DEBUG=y/ to /# CONFIG.*DEBUG is not set/.

This misses a few CONFIG options where "DEBUG" is toward the middle
of the CONFIG option, like CONFIG_DEBUG_RSEQ, CONFIG_DEBUG_TEST_DRIVER_REMOVE,
CONFIG_C710_DEBUG_ASSUMPTIONS, CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING,
CONFIG_DRM_DEBUG_xyzzz (a few like this), CONFIG_DEBUG_KERNEL_DC,
CONFIG_NOUVEAU_DEBUG_xyzzz (a few), CONFIG_DRM_I915_DEBUG_xyzzz (a few),
CONFIG_SND_SOC_SOF_xyzzz (several), CONFIG_HFI1_DEBUG_SDMA_ORDER,
CONFIG_AFS_DEBUG_CURSOR, CONFIG_DEBUG_NET, lots of entries in the
Kernel Hacking menu. Then there are several SELFTEST config options,
but they are not always spelled "SELFTEST"; they might just be spelled
TEST or TESTS.

I'll attach a Perl script (from 2009) that begins the work on option 1,
but I haven't used it since forever.

(2) Make a "mini.config" file that contains a list of all the options that you
want to have set in a certain way (can be either enabled or disabled).
Then use
$ KCONFIG_ALLCONFIG=your.mini.config make allmodconfig

This is the documented and supported way. It is documented in
Documentation/kbuild/kconfig.rst:

<begin quote>

KCONFIG_ALLCONFIG
-----------------
(partially based on lkml email from/by Rob Landley, re: miniconfig)

--------------------------------------------------

The allyesconfig/allmodconfig/allnoconfig/randconfig variants can also
use the environment variable KCONFIG_ALLCONFIG as a flag or a filename
that contains config symbols that the user requires to be set to a
specific value.  If KCONFIG_ALLCONFIG is used without a filename where
KCONFIG_ALLCONFIG == "" or KCONFIG_ALLCONFIG == "1", `make *config`
checks for a file named "all{yes/mod/no/def/random}.config"
(corresponding to the `*config` command that was used) for symbol values
that are to be forced.  If this file is not found, it checks for a
file named "all.config" to contain forced values.

This enables you to create "miniature" config (miniconfig) or custom
config files containing just the config symbols that you are interested
in.  Then the kernel config system generates the full .config file,
including symbols of your miniconfig file.

This 'KCONFIG_ALLCONFIG' file is a config file which contains
(usually a subset of all) preset config symbols.  These variable
settings are still subject to normal dependency checks.

Examples::

	KCONFIG_ALLCONFIG=custom-notebook.config make allnoconfig

or::

	KCONFIG_ALLCONFIG=mini.config make allnoconfig

or::

	make KCONFIG_ALLCONFIG=mini.config allnoconfig

These examples will disable most options (allnoconfig) but enable or
disable the options that are explicitly listed in the specified
mini-config files.

<end quote>

Note that this only works with "make allyesconfig/allmodconfig/allnoconfig/randconfig"
variants.  You could try it and see if it works for you.

I'll also attach a sample "disable.all.debug.config" file for this option.
You will need to update this CONFIG options list continually.

HTH. Good luck.

-- 
~Randy
--------------Mgy6DUrtLwqyLcxdknj6b30y
Content-Type: text/plain; charset=UTF-8; name="config.debug.off"
Content-Disposition: attachment; filename="config.debug.off"
Content-Transfer-Encoding: base64

IyEgL3Vzci9iaW4vcGVybAojIGNvbmZpZy5kZWJ1Zy5vZmY6IGNoYW5nZSBhbGwgL0NPTkZJ
R194eXpfREVCVUc9eS8gdG8gLyMgQ09ORklHX3h5el9ERUJVRyBpcyBub3Qgc2V0LwojIFJh
bmR5IER1bmxhcCwgQXByaWwtMjAwOQojCiRWRVIgPSAiMDAxIjsKCnVzZSBHZXRvcHQ6OlN0
ZDsKCmdldG9wdHMoInYiKTsKCm15ICRjaGFuZ2Vjb3VudCA9IDA7CgpzdWIgdXNhZ2UoKSB7
CglwcmludCAidXNhZ2U6IGNvbmZpZy5kZWJ1Zy5vZmYgWy12XSA8IGNvbmZpZy5maWxlMSA+
IGNvbmZpZy5maWxlMiBbdmVyLiAkVkVSXVxuIjsKCXByaW50ICIgIC12IDogdmVyYm9zZVxu
IjsKCWV4aXQgKDEpOwp9CgojI2lmICgkb3B0X3YpIHsgfQoKTElORTogd2hpbGUgKCRsaW5l
ID0gPFNURElOPikgewoJY2hvbXAgJGxpbmU7CgoJaWYgKCRsaW5lID1+IC9eKENPTkZJRy4q
X0RFQlVHKT15LykgewoJCXByaW50ICIjICQxIGlzIG5vdCBzZXRcbiI7CgkJJGNoYW5nZWNv
dW50Kys7Cgl9CgllbHNlIHsKCQlwcmludCAiJGxpbmVcbiI7Cgl9Cn0KCnByaW50ZiBTVERF
UlIgIiRjaGFuZ2Vjb3VudCBsaW5lcyBjaGFuZ2VkXG4iOwo=
--------------Mgy6DUrtLwqyLcxdknj6b30y
Content-Type: application/x-config; name="disable.all.debug.config"
Content-Disposition: attachment; filename="disable.all.debug.config"
Content-Transfer-Encoding: base64

IyB0ZXN0OiBLQ09ORklHX0FMTENPTkZJRz1kaXNhYmxlLmFsbC5kZWJ1Zy5jb25maWcgbWFr
ZSBhbGxtb2Rjb25maWcKIyBDT05GSUdfUE1fREVCVUcgaXMgbm90IHNldAojIENPTkZJR19G
VFJBQ0UgaXMgbm90IHNldAojIGRpc2FibGUgb3RoZXIgZGVidWcvc2VsZi10ZXN0cy9mZWF0
dXJlIHRlc3RpbmcKIyBDT05GSUdfQ0dST1VQX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdf
REVCVUdfQkxLX0NHUk9VUCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1BFUkZfVVNFX1ZN
QUxMT0MgaXMgbm90IHNldAojIENPTkZJR19MRE1fREVCVUcgaXMgbm90IHNldAojIENPTkZJ
R19QQVJBVklSVF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NNQV9ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RFQlVHX0hPVFBMVUdfQ1BVMCBpcyBub3Qgc2V0CiMgQ09ORklHX0FD
UElfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX0RFQlVHR0VSIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUNQSV9BUEVJX0VSU1RfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19QQ0lF
QVNQTV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX1JBUElESU9fREVCVUcgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfREVC
VUcgaXMgbm90IHNldAojIENPTkZJR19JUF9WU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklH
X0lQX0RDQ1BfQ0NJRDJfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19JUF9EQ0NQX0NDSUQz
X0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfRENDUF9URlJDX0RFQlVHIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBfRENDUF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1JEU19ERUJV
RyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVE1BTl9BRFZfREVCVUcgaXMgbm90IHNldAojIENP
TkZJR19DQU5fREVCVUdfREVWSUNFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lSREFfREVCVUcg
aXMgbm90IHNldAojIENPTkZJR19BRl9SWFJQQ19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NGRzgwMjExX1JFR19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0xJQjgwMjExX0RFQlVH
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTFfREVCVUdfTUVOVSBpcyBub3Qgc2V0CiMg
Q09ORklHX05MODAyMTFfVEVTVE1PREUgaXMgbm90IHNldAojIENPTkZJR19ORVRfOVBfREVC
VUcgaXMgbm90IHNldAojIENPTkZJR19DQUlGX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q0VQSF9MSUJfUFJFVFRZREVCVUcgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19EUklWRVIg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19ERVZSRVMgaXMgbm90IHNldAojIENPTkZJR19N
VERfUE1DNTUxX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1RFU1RTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUE5QX0RFQlVHX01FU1NBR0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0dJ
X0dSVV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NCNzEwX0RFQlVHIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUlDN1hYWF9ERUJVR19FTkFCTEUgaXMgbm90IHNldAojIENPTkZJR19BSUM3
OVhYX0RFQlVHX0VOQUJMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0FJQzk0WFhfREVCVUcgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX01WU0FTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9PU0RfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19CQ0FDSEVfREVCVUcgaXMgbm90
IHNldAojIENPTkZJR19CQ0FDSEVfRURFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNBQ0hF
X0NMT1NVUkVTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fREVCVUcgaXMgbm90IHNl
dAojIENPTkZJR19ETV9ERUJVR19CTE9DS19TVEFDS19UUkFDSU5HIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVRNX0VOSV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTV9aQVRNX0RFQlVH
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNX0lEVDc3MjUyX0RFQlVHIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVRNX0FNQkFTU0FET1JfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19BVE1fSE9S
SVpPTl9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTV9JQV9ERUJVRyBpcyBub3Qgc2V0
CiMgQ09ORklHX0FUTV9GT1JFMjAwRV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZYR0Vf
REVCVUdfVFJBQ0VfQUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfU0tHRV9ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NLWTJfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NTFg0X0RFQlVH
IGlzIG5vdCBzZXQKIyBDT05GSUdfTElCRVJUQVNfVEhJTkZJUk1fREVCVUcgaXMgbm90IHNl
dAojIENPTkZJR19BVEhfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19BVEg1S19ERUJVRyBp
cyBub3Qgc2V0CiMgQ09ORklHX0FUSDZLTF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0FU
SDEwS19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0I0M19ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX0I0M0xFR0FDWV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVzIxMDBfREVC
VUcgaXMgbm90IHNldAojIENPTkZJR19JUFcyMjAwX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05G
SUdfTElCSVBXX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfSVdMV0lGSV9ERUJVRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lXTFdJRklfREVCVUdfRVhQRVJJTUVOVEFMX1VDT0RFIGlzIG5v
dCBzZXQKIyBDT05GSUdfSVdMRUdBQ1lfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19MSUJF
UlRBU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUMlgwMF9ERUJVRyBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUTFdJRklfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19aRDEyMTFSV19E
RUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJU0FYX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05G
SUdfR0lHQVNFVF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19DT1JFIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0FMR08gaXMgbm90IHNldAojIENPTkZJR19J
MkNfREVCVUdfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX0RFQlVHIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFBTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUElOQ1RSTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19QT1dF
Ul9TVVBQTFlfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19IV01PTl9ERUJVR19DSElQIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkNNQV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VM
QVRPUl9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0FEVl9ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9QV0NfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19WSURFT19Q
VlJVU0IyX0RFQlVHSUZDIGlzIG5vdCBzZXQKIyBDT05GSUdfRFZCX1VTQl9ERUJVRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RWQl9CMkMyX0ZMRVhDT1BfVVNCX0RFQlVHIGlzIG5vdCBzZXQK
IyBDT05GSUdfRFZCX0IyQzJfRkxFWENPUF9QQ0lfREVCVUcgaXMgbm90IHNldAojIENPTkZJ
R19EVkJfQjJDMl9GTEVYQ09QX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTlZJRElB
X0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUklWQV9ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZCX0lOVEVMX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUkFERU9OX0RF
QlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX09UR19XSElURUxJU1QgaXMgbm90
IHNldAojIENPTkZJR19VU0JfT1RHX0JMQUNLTElTVF9IVUIgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfV1VTQl9DQkFGX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hDRF9URVNU
X01PREUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9ERUJVRyBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9EV0MzX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NISVBJ
REVBX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dBREdFVF9ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9HQURHRVRfREVCVUdfRklMRVMgaXMgbm90IHNldAojIENPTkZJ
R19NTUNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NRU1TVElDS19ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0lORklOSUJBTkRfTVRIQ0FfREVCVUcgaXMgbm90IHNldAojIENPTkZJ
R19JTkZJTklCQU5EX0FNU08xMTAwX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5GSU5J
QkFORF9DWEdCM19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0lORklOSUJBTkRfTkVTX0RF
QlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5GSU5JQkFORF9JUE9JQl9ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0VEQUNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19SVENfREVCVUcg
aXMgbm90IHNldAojIENPTkZJR19ETUFERVZJQ0VTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05G
SUdfRE1BVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQklQX0RFQlVHIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ09NRURJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRTNTEzOV9ERUJV
RyBpcyBub3Qgc2V0CiMgQ09ORklHX1pSQU1fREVCVUcgaXMgbm90IHNldAojIENPTkZJR19V
U0JfRFdDMl9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0xVU1RSRV9ERUJVR19FWFBFTlNJ
VkVfQ0hFQ0sgaXMgbm90IHNldAojIENPTkZJR19GVUpJVFNVX0xBUFRPUF9ERUJVRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RISU5LUEFEX0FDUElfREVCVUdGQUNJTElUSUVTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVEhJTktQQURfQUNQSV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0NP
TU1PTl9DTEtfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19FWFQ0X0RFQlVHIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSkJEX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfSkJEMl9ERUJVRyBp
cyBub3Qgc2V0CiMgQ09ORklHX0pGU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1hGU19E
RUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX09DRlMyX0RFQlVHX01BU0tMT0cgaXMgbm90IHNl
dAojIENPTkZJR19CVFJGU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1FVT1RBX0RFQlVH
IGlzIG5vdCBzZXQKIyBDT05GSUdfRlNDQUNIRV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NBQ0hFRklMRVNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19OVEZTX0RFQlVHIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkVGU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1FOWDZGU19E
RUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VGU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklH
X0VYT0ZTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTX0RFQlVHIGlzIG5vdCBzZXQK
IyBDT05GSUdfU1VOUlBDX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lGU19ERUJVRyBp
cyBub3Qgc2V0CiMgQ09ORklHX0NJRlNfREVCVUcyIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZT
X0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfRExNX0RFQlVHIGlzIG5vdCBzZXQKIyBrZXJu
ZWwgaGFja2luZy9UUkFDRS9ERUJVRyBzdHVmZiBpcyBhIG1lc3MKIyBDT05GSUdfREVCVUdf
UEFHRUFMTE9DIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0k5MTVfREVCVUcgaXMgbm90IHNl
dAojIENPTkZJR19EUk1fSTkxNV9TV19GRU5DRV9ERUJVR19PQkpFQ1RTIGlzIG5vdCBzZXQK
IyBDT05GSUdfRFJNX0k5MTVfU0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19P
QkpFQ1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfS01FTUxFQUsgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19WTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1ZNX1JCIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfUEVSX0NQVV9NQVBTIGlzIG5vdCBzZXQKIyBDT05GSUdf
REVCVUdfUlRfTVVURVhFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUX01VVEVYX1RFU1RFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1dXX01VVEVYX1NMT1dQQVRIIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFJPVkVfTE9DS0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0xPQ0tE
RVAgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19MT0NLSU5HX0FQSV9TRUxGVEVTVFMgaXMg
bm90IHNldAojIENPTkZJR19ERUJVR19LT0JKRUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfTElTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NHIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfQ1JFREVOVElBTFMgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19CTE9DS19F
WFRfREVWVCBpcyBub3Qgc2V0CiMgQ09ORklHX05PVElGSUVSX0VSUk9SX0lOSkVDVElPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZBVUxUX0lOSkVDVElPTiBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX1NUUklDVF9VU0VSX0NPUFlfQ0hFQ0tTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNV
X1RSQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVFJBQ0VfQ0xPQ0sgaXMgbm90IHNldAojIENP
TkZJR19ETUFfQVBJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfS0dEQl9URVNUUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX1JPREFUQSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X1NFVF9NT0RVTEVfUk9OWCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1RMQkZMVVNIIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU9NTVVfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19JT01N
VV9TVFJFU1MgaXMgbm90IHNldAojIENPTkZJR19DUEFfREVCVUcgaXMgbm90IHNldAojIENP
TkZJR19LQVNBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VCU0FOIGlzIG5vdCBzZXQKIyBDT05G
SUdfS0NPViBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTVBJTEVfVEVTVCBpcyBub3Qgc2V0CiNF
TkQjCg==

--------------Mgy6DUrtLwqyLcxdknj6b30y--
